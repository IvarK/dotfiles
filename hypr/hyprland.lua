-- Hyprland 0.55+ Lua configuration.
-- Select a machine profile with: ~/.config/hypr/symlinks.sh home|work
require("configs.envvariables")
require("configs.startupapps")
require("configs.other")

-- Bindings use the default submap, so no startup dispatch is needed.
require("configs.keybinds")
require("configs.windowrules")
require("configs.appearance")
require("configs.animations")
require("configs.general")
require("configs.monitors")
require("configs.workspaces")
