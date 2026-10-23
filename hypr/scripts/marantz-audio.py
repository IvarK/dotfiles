#!/usr/bin/env python3
"""Route desktop audio according to the SR6010 main-zone power and input."""

import argparse
import json
import logging
import os
from pathlib import Path
import signal
import subprocess
import threading
import time
import urllib.request
import xml.etree.ElementTree as ET


CARD = "alsa_card.pci-0000_07_00.1"
# HDMI 4 is the Marantz receiver; use six-channel PCM for 5.1 games.
PROFILE = "output:hdmi-surround-extra3"
HDMI = "alsa_output.pci-0000_07_00.1.hdmi-surround-extra3"
FALLBACK = "alsa_output.usb-SteelSeries_SteelSeries_Arctis_7-00.stereo-game"


def receiver_active(xml, source):
    root = ET.fromstring(xml)
    # The Status endpoint returns canonical AUX2, even when renamed to PC.
    power = root.findtext("ZonePower/value") or root.findtext("Power/value")
    selected = root.findtext("InputFuncSelect/value")
    if power is None or selected is None:
        raise ValueError("Receiver response is missing power or input")
    power = power.strip().upper()
    if power not in {"ON", "OFF", "STANDBY"}:
        raise ValueError(f"Unknown receiver power state: {power}")
    return power == "ON" and selected.strip().upper() == source.upper()


def read_receiver(host, source):
    # Local receiver traffic must not go through an HTTP proxy.
    opener = urllib.request.build_opener(urllib.request.ProxyHandler({}))
    url = f"http://{host}/goform/formMainZone_MainZoneXmlStatus.xml"
    with opener.open(url, timeout=3) as response:
        return receiver_active(response.read(128 * 1024), source)


def pactl(*args):
    return subprocess.run(
        ["pactl", *args], check=True, capture_output=True, text=True, timeout=5
    ).stdout.strip()


class AudioRouter:
    def __init__(self, state_path):
        self.state_path = state_path
        self.previous = json.loads(state_path.read_text()) if state_path.exists() else None

    def sinks(self):
        return {sink["name"]: sink["index"] for sink in json.loads(pactl("-f", "json", "list", "sinks"))}

    def profile(self):
        cards = json.loads(pactl("-f", "json", "list", "cards"))
        return next(card["active_profile"] for card in cards if card["name"] == CARD)

    def wait_for_sink(self, name):
        for _ in range(30):
            sinks = self.sinks()
            if name in sinks:
                return sinks[name]
            time.sleep(0.1)
        raise RuntimeError(f"Audio output did not appear: {name}")

    def save(self, previous):
        temporary = self.state_path.with_suffix(".tmp")
        temporary.write_text(json.dumps(previous))
        temporary.chmod(0o600)
        temporary.replace(self.state_path)
        self.previous = previous

    def streams_on(self, old_index):
        if old_index is None:
            return []
        return [stream["index"] for stream in json.loads(pactl("-f", "json", "list", "sink-inputs"))
                if stream["sink"] == old_index]

    def move_streams(self, streams, target):
        for index in streams:
            try:
                pactl("move-sink-input", str(index), target)
            except subprocess.CalledProcessError:
                # A stream can finish between listing and moving it.
                logging.warning("Could not move audio stream %s", index)

    def activate(self):
        current = pactl("get-default-sink")
        streams = self.streams_on(self.sinks().get(current))
        profile = self.profile()
        if self.previous is None:
            # Save before changing the profile/default, for recovery after a restart.
            self.save({"sink": current if current != HDMI else FALLBACK, "profile": profile})
        if profile != PROFILE:
            pactl("set-card-profile", CARD, PROFILE)
        self.wait_for_sink(HDMI)
        pactl("set-default-sink", HDMI)
        self.move_streams(streams, HDMI)
        logging.info("Receiver on AUX2: audio -> Marantz HDMI 5.1")

    def restore(self):
        if self.previous is None:
            return
        current = pactl("get-default-sink")
        if current == HDMI:
            streams = self.streams_on(self.sinks().get(HDMI))
            previous_profile = self.previous["profile"]
            if self.profile() != previous_profile:
                pactl("set-card-profile", CARD, previous_profile)
            target = self.previous["sink"]
            try:
                self.wait_for_sink(target)
            except RuntimeError:
                target = FALLBACK
                self.wait_for_sink(target)
            pactl("set-default-sink", target)
            self.move_streams(streams, target)
            logging.info("Receiver inactive: audio -> %s", target)
        else:
            # Respect a manual output change made while the receiver was selected.
            logging.info("Keeping manually selected audio output: %s", current)
        self.state_path.unlink(missing_ok=True)
        self.previous = None


class StableState:
    """Require two matching samples; tolerate two failed network requests."""

    def __init__(self):
        self.candidate = None
        self.samples = 0
        self.failures = 0

    def update(self, active):
        if active is None:
            self.failures += 1
            self.candidate = None
            self.samples = 0
            return False if self.failures >= 3 else None
        self.failures = 0
        self.samples = self.samples + 1 if self.candidate == active else 1
        self.candidate = active
        return active if self.samples >= 2 else None


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--host", default="192.168.1.23")
    parser.add_argument("--input", default="AUX2")
    parser.add_argument("--status", action="store_true", help="Read receiver state without changing audio")
    args = parser.parse_args()
    logging.basicConfig(level=logging.INFO, format="%(message)s")
    if args.status:
        print("active" if read_receiver(args.host, args.input) else "inactive")
        return

    router = AudioRouter(Path(os.environ["XDG_RUNTIME_DIR"]) / "marantz-audio-state.json")
    stop = threading.Event()
    for signum in (signal.SIGTERM, signal.SIGINT):
        signal.signal(signum, lambda *_: stop.set())
    stable = StableState()
    applied = None
    try:
        while not stop.is_set():
            try:
                active = read_receiver(args.host, args.input)
            except (OSError, ValueError, ET.ParseError) as error:
                if stable.failures == 0:
                    logging.warning("Receiver unavailable: %s", error)
                active = None
            desired = stable.update(active)
            if desired is not None and desired != applied:
                try:
                    router.activate() if desired else router.restore()
                    applied = desired
                except (OSError, ValueError, RuntimeError, StopIteration, subprocess.SubprocessError) as error:
                    logging.warning("Audio switch failed; will retry: %s", error)
            stop.wait(3)
    finally:
        router.restore()


if __name__ == "__main__":
    main()
