hl.on("hyprland.start", function()
    hl.exec_cmd("steam")
    hl.exec_cmd([[systemd-run --user --unit=marantz-audio --collect --property=Restart=on-failure --property=RestartSec=5 --property=PartOf=graphical-session.target python3 "$HOME/.config/hypr/scripts/marantz-audio.py"]])
end)

hl.on("hyprland.shutdown", function()
    hl.exec_cmd("systemctl --user --no-block stop marantz-audio.service")
end)
