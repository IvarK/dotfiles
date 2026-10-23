-- Utilities.
hl.bind("SUPER_L", hl.dsp.exec_cmd("pgrep -x rofi >/dev/null && pkill -x rofi || rofi -show drun -hover-select -me-select-entry '' -me-accept-entry MousePrimary"), { ignore_mods = true, release = true })
hl.bind("SUPER + B", hl.dsp.exec_cmd("vivaldi"))
hl.bind("SUPER + Return", hl.dsp.exec_cmd("kitty"))
hl.bind("SUPER + SHIFT + Return", hl.dsp.exec_cmd("kitty", {
    float = true,
    move = { "monitor_w * 0.15", "monitor_h * 0.05" },
    size = { "monitor_w * 0.7", "monitor_h * 0.6" },
}))
hl.bind("SUPER + E", hl.dsp.exec_cmd("nemo"))

-- Media keys remain available while locked.
hl.bind("XF86Sleep", hl.dsp.exec_cmd("systemctl suspend"), { locked = true })
for _, key in ipairs({ "XF86AudioPause", "XF86AudioPlay" }) do
    hl.bind(key, hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
end
hl.bind("XF86AudioNext", hl.dsp.exec_cmd([[playerctl next || playerctl position `bc <<< "100 * $(playerctl metadata mpris:length) / 1000000 / 100"`]]), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true, repeating = true })

hl.bind("SUPER + CTRL + S", hl.dsp.exec_cmd("$HOME/.config/hypr/scripts/ScreenShot.sh --swappy"))
hl.bind("SUPER + Tab", hl.dsp.focus({ workspace = "m+1" }))
hl.bind("SUPER + SHIFT + Tab", hl.dsp.focus({ workspace = "m-1" }))
hl.bind("SUPER + P", hl.dsp.exec_cmd([[project shortlist | rofi -dmenu -sep " " -p "Project:" | xargs -r project]], { workspace = "7 silent" }))
hl.bind("SUPER + C", hl.dsp.exec_cmd("$HOME/.config/hypr/scripts/code-launch.sh"))

-- Move windows and focus with WASD.
for key, direction in pairs({ W = "up", A = "left", S = "down", D = "right" }) do
    hl.bind("SUPER + " .. key, hl.dsp.window.move({ direction = direction }))
    hl.bind("SUPER + SHIFT + " .. key, hl.dsp.focus({ direction = direction }))
end

-- Resize windows with the arrow keys.
for key, delta in pairs({ up = { 0, -50 }, left = { -50, 0 }, down = { 0, 50 }, right = { 50, 0 } }) do
    hl.bind("SUPER + " .. key, hl.dsp.window.resize({ x = delta[1], y = delta[2], relative = true }), { repeating = true })
end

hl.bind("SUPER + SHIFT + I", hl.dsp.layout("togglesplit"))
hl.bind("SUPER + Q", hl.dsp.window.close())
hl.bind("SUPER + SHIFT + Q", hl.dsp.exec_cmd("bash \"$HOME/.config/hypr/scripts/KillActiveProcess.sh\""), { description = "Kill active process" })
hl.bind("SUPER + L", hl.dsp.exec_cmd("loginctl lock-session"), { description = "Lock" })
hl.bind("SUPER + SHIFT + L", hl.dsp.exec_cmd("pgrep -x wlogout >/dev/null && pkill -x wlogout || wlogout -b 2"))

hl.bind("SUPER + SHIFT + U", hl.dsp.window.move({ workspace = "special", follow = true }))
hl.bind("SUPER + U", hl.dsp.workspace.toggle_special())

-- Physical number keys preserve the bindings with the Finnish keyboard layout.
for workspace = 1, 10 do
    local key = "code:" .. (workspace + 9)
    hl.bind("SUPER + " .. key, hl.dsp.focus({ workspace = workspace }))
    hl.bind("SUPER + SHIFT + " .. key, hl.dsp.window.move({ workspace = workspace, follow = true }))
    hl.bind("SUPER + CTRL + " .. key, hl.dsp.window.move({ workspace = workspace, follow = false }))
end

hl.bind("SUPER + mouse_down", hl.dsp.focus({ workspace = "m+1" }))
hl.bind("SUPER + mouse_up", hl.dsp.focus({ workspace = "m-1" }))
hl.bind("SUPER + period", hl.dsp.focus({ workspace = "e+1" }))
hl.bind("SUPER + comma", hl.dsp.focus({ workspace = "e-1" }))
hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })
hl.bind("mouse:272", hl.dsp.exec_cmd("pgrep -x rofi >/dev/null && pkill -x rofi"), { non_consuming = true })

hl.bind("SUPER + SHIFT + F", hl.dsp.window.fullscreen({ mode = "fullscreen" }))
hl.bind("SUPER + CTRL + F", hl.dsp.window.fullscreen({ mode = "maximized" }))

-- Adjust magnification directly through the Lua API.
local function zoom(multiplier)
    local factor = math.max(1, hl.get_config("cursor.zoom_factor"))
    hl.config({ cursor = { zoom_factor = factor * multiplier } })
end
hl.bind("SUPER + SHIFT + mouse_down", function() zoom(2) end)
hl.bind("SUPER + SHIFT + mouse_up", function() zoom(0.5) end)
