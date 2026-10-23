Hyprland uses `hyprland.lua` and the modules in `configs/` (Hyprland 0.55 or newer).
Keybindings are in `configs/keybinds.lua`; window and layer rules are in
`configs/windowrules.lua`.

Select the machine's monitors, workspaces, startup apps and idle behavior:

```sh
~/.config/hypr/symlinks.sh home
# or: ~/.config/hypr/symlinks.sh work
```

Validate the selected profile with:

```sh
Hyprland --verify-config -c ~/.config/hypr/hyprland.lua
```

The legacy Hyprland `.conf` files have been removed. Edit the Lua files and apply
changes with `hyprctl reload`. An existing session still using the legacy format
needs a logout and login to switch to Lua; a reload cannot switch formats.

Wallust generates `wallust/wallust-hyprland.lua` for Hyprland and
`wallust/wallust-hyprland.conf` for Hyprlock. Generate the palettes with
`wallust run /path/to/wallpaper -s` when setting up a new checkout.
Hyprlock, Hypridle and Hyprpaper continue to use their `.conf` files.

The home profile starts `marantz-audio.service` as a transient user service.
It polls the SR6010 at `192.168.1.23` every three seconds and switches desktop
audio to HDMI 4 using the Digital Surround 5.1 profile (six-channel PCM) when
the main zone is on AUX2 (renamed PC). Turning the receiver off or selecting
another input restores the previous output. Two matching
samples are required before switching; three failed requests trigger a fallback.
TV power and input are not checked. Keep the receiver on a reserved DHCP address;
its Network Control / IP Control setting should be Always On for status queries
in standby.

Games should use their 5.1 / home-theater speaker setting; restart games that
were launched while the headset or stereo profile was selected. Use Auto or
Multi Ch In on the receiver for multichannel PCM; its Stereo mode downmixes
multichannel audio to two channels.

The helper moves streams from the old default output and leaves streams on other
outputs alone. Manual output changes remain in effect until the next receiver
state transition. Its saved previous output survives service restarts in the
user runtime directory. Stop the service to restore audio and disable switching
for the current session:

```sh
systemctl --user stop marantz-audio.service
journalctl --user -u marantz-audio.service
python3 ~/.config/hypr/scripts/marantz-audio.py --status
```
