import importlib.util
import json
from pathlib import Path
import tempfile
import unittest
from unittest.mock import patch


spec = importlib.util.spec_from_file_location("marantz_audio", Path(__file__).resolve().parents[1] / "marantz-audio.py")
audio = importlib.util.module_from_spec(spec)
spec.loader.exec_module(audio)


class ReceiverTests(unittest.TestCase):
    def test_power_and_canonical_input(self):
        for power, source, expected in [("ON", "AUX2", True), ("ON", "GAME", False), ("STANDBY", "AUX2", False)]:
            with self.subTest(power=power, source=source):
                xml = f"<item><Power><value>{power}</value></Power><InputFuncSelect><value>{source}</value></InputFuncSelect><RenameSource><value>PC</value></RenameSource></item>"
                self.assertEqual(audio.receiver_active(xml, "AUX2"), expected)

    def test_main_zone_off_even_if_receiver_power_is_on(self):
        xml = "<item><Power><value>ON</value></Power><ZonePower><value>OFF</value></ZonePower><InputFuncSelect><value>AUX2</value></InputFuncSelect></item>"
        self.assertFalse(audio.receiver_active(xml, "AUX2"))

    def test_incomplete_response_is_not_a_power_off_event(self):
        with self.assertRaises(ValueError):
            audio.receiver_active("<item><Power><value>ON</value></Power></item>", "AUX2")

    def test_debounce_failures_and_recovery(self):
        stable = audio.StableState()
        samples = [True, True, False, True, True, None, None, None, True, True, False, False]
        expected = [None, True, None, None, True, None, None, False, None, True, None, False]
        self.assertEqual([stable.update(value) for value in samples], expected)


class FakeAudio:
    def __init__(self):
        self.default = audio.FALLBACK
        self.profile = "output:hdmi-stereo"
        self.monitor_sink = "alsa_output.pci-0000_07_00.1.hdmi-stereo"
        self.sinks = {audio.FALLBACK: 46, "chat": 34, self.monitor_sink: 61}
        self.streams = {100: 46, 101: 34}
        self.moves = []

    def pactl(self, *args):
        if args == ("get-default-sink",):
            return self.default
        if args == ("-f", "json", "list", "sinks"):
            return json.dumps([{"name": name, "index": index} for name, index in self.sinks.items()])
        if args == ("-f", "json", "list", "cards"):
            return json.dumps([{"name": audio.CARD, "active_profile": self.profile}])
        if args == ("-f", "json", "list", "sink-inputs"):
            return json.dumps([{"index": index, "sink": sink} for index, sink in self.streams.items()])
        if args[0] == "set-card-profile":
            self.profile = args[2]
            self.sinks.pop(self.monitor_sink, None)
            self.sinks.pop(audio.HDMI, None)
            name = audio.HDMI if self.profile == audio.PROFILE else self.monitor_sink
            self.sinks[name] = 200 if name == audio.HDMI else 61
            # A profile change removes the old sink; policy may move its streams.
            for index, sink in self.streams.items():
                if sink not in self.sinks.values():
                    self.streams[index] = 46
            if self.default not in self.sinks:
                self.default = audio.FALLBACK
            return ""
        if args[0] == "set-default-sink":
            assert args[1] in self.sinks
            self.default = args[1]
            return ""
        if args[0] == "move-sink-input":
            self.moves.append((int(args[1]), args[2]))
            self.streams[int(args[1])] = self.sinks[args[2]]
            return ""
        raise AssertionError(f"Unexpected command: {args}")


class RoutingTests(unittest.TestCase):
    def setUp(self):
        self.directory = tempfile.TemporaryDirectory()
        self.addCleanup(self.directory.cleanup)
        self.path = Path(self.directory.name) / "state.json"
        self.fake = FakeAudio()
        self.patcher = patch.object(audio, "pactl", self.fake.pactl)
        self.patcher.start()
        self.addCleanup(self.patcher.stop)
        self.router = audio.AudioRouter(self.path)

    def test_switch_and_restore_without_moving_chat_audio(self):
        self.router.activate()
        self.assertEqual(self.fake.default, audio.HDMI)
        self.assertEqual(self.fake.streams, {100: 200, 101: 34})
        self.router.restore()
        self.assertEqual(self.fake.default, audio.FALLBACK)
        self.assertEqual(self.fake.profile, "output:hdmi-stereo")
        self.assertEqual(self.fake.streams, {100: 46, 101: 34})
        self.assertFalse(self.path.exists())

    def test_restore_survives_process_restart(self):
        self.router.activate()
        restarted = audio.AudioRouter(self.path)
        restarted.activate()
        self.assertEqual(restarted.previous["sink"], audio.FALLBACK)
        restarted.restore()
        self.assertEqual(self.fake.default, audio.FALLBACK)

    def test_manual_output_selection_is_preserved(self):
        self.router.activate()
        self.fake.default = "chat"
        self.router.restore()
        self.assertEqual(self.fake.default, "chat")
        self.assertFalse(self.path.exists())

    def test_profile_change_still_moves_original_streams(self):
        self.fake.default = self.fake.monitor_sink
        self.fake.streams[100] = 61
        self.router.activate()
        self.assertEqual(self.fake.streams[100], 200)
        self.router.restore()
        self.assertEqual(self.fake.default, self.fake.monitor_sink)
        self.assertEqual(self.fake.streams[100], 61)

    def test_already_selected_hdmi_does_not_become_its_own_fallback(self):
        self.fake.pactl("set-card-profile", audio.CARD, audio.PROFILE)
        self.fake.default = audio.HDMI
        self.router.activate()
        self.router.restore()
        self.assertEqual(self.fake.default, audio.FALLBACK)

    def test_inactive_without_saved_state_leaves_audio_alone(self):
        self.router.restore()
        self.assertEqual(self.fake.default, audio.FALLBACK)
        self.assertEqual(self.fake.moves, [])


if __name__ == "__main__":
    unittest.main()
