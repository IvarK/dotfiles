hl.on("hyprland.start", function()
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")

    -- Polkit authentication agent.
    -- hl.exec_cmd("$HOME/.config/hypr/scripts/Polkit.sh")

    hl.exec_cmd("nm-applet --indicator")
    hl.exec_cmd("discord")
    hl.exec_cmd("Telegram")
    hl.exec_cmd("waybar")

    -- Clipboard history and primary selection.
    hl.exec_cmd("wl-paste --type text --watch cliphist store")
    hl.exec_cmd("wl-paste --type image --watch cliphist store")
    hl.exec_cmd("wl-paste --primary --watch wl-copy")

    hl.exec_cmd("hypridle")
    hl.exec_cmd("hyprpaper")
    hl.exec_cmd("waypaper --restore")
end)
