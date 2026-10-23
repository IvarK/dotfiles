-- Window and layer rules, evaluated in their original order.
-- https://wiki.hypr.land/configuring/core/rules/window-rules/

-- browser tags
hl.window_rule({ match = { class = "^([Ff]irefox|org.mozilla.firefox|[Ff]irefox-esr|[Ff]irefox-bin)$" }, tag = "+browser" })
hl.window_rule({ match = { class = "^([Gg]oogle-chrome(-beta|-dev|-unstable)?)$" }, tag = "+browser" })
hl.window_rule({ match = { class = "^(chrome-.+-Default)$" }, tag = "+browser" }) -- Chrome PWAs
hl.window_rule({ match = { class = "^([Cc]hromium)$" }, tag = "+browser" })
hl.window_rule({ match = { class = "^([Mm]icrosoft-edge(-stable|-beta|-dev|-unstable))$" }, tag = "+browser" })
hl.window_rule({ match = { class = "^(Brave-browser(-beta|-dev|-unstable)?)$" }, tag = "+browser" })
hl.window_rule({ match = { class = "^([Tt]horium-browser|[Cc]achy-browser)$" }, tag = "+browser" })
hl.window_rule({ match = { class = "^(zen-alpha|zen)$" }, tag = "+browser" })
hl.window_rule({ match = { class = "^([Vv]ivaldi-stable)$" }, tag = "+browser" })

-- notif tags
hl.window_rule({ match = { class = "^(swaync-control-center|swaync-notification-window|swaync-client|class)$" }, tag = "+notif" })

-- terminal tags
hl.window_rule({ match = { class = "^(Alacritty|kitty|kitty-dropterm)$" }, tag = "+terminal" })

-- email tags
hl.window_rule({ match = { class = "^([Tt]hunderbird|org.gnome.Evolution)$" }, tag = "+email" })
hl.window_rule({ match = { class = "^(eu.betterbird.Betterbird)$" }, tag = "+email" })

-- project tags
hl.window_rule({ match = { class = "^(codium|codium-url-handler|VSCodium)$" }, tag = "+projects" })
hl.window_rule({ match = { class = "^(VSCode|code-url-handler)$" }, tag = "+projects" })
hl.window_rule({ match = { class = "^(jetbrains-.+)$" }, tag = "+projects" }) -- JetBrains IDEs

-- screenshare tags
hl.window_rule({ match = { class = "^(com.obsproject.Studio)$" }, tag = "+screenshare" })

-- IM tags
hl.window_rule({ match = { class = "^([Dd]iscord|[Ww]ebCord|[Vv]esktop)$" }, tag = "+im" })
hl.window_rule({ match = { class = "^([Ff]erdium)$" }, tag = "+im" })
hl.window_rule({ match = { class = "^([Ww]hatsapp-for-linux)$" }, tag = "+im" })
hl.window_rule({ match = { class = "^(ZapZap|com.rtosta.zapzap)$" }, tag = "+im" })
hl.window_rule({ match = { class = "^(org.telegram.desktop|io.github.tdesktop_x64.TDesktop)$" }, tag = "+im" })
hl.window_rule({ match = { class = "^(teams-for-linux)$" }, tag = "+im" })

-- game tags
hl.window_rule({ match = { class = "^(gamescope)$" }, tag = "+games" })
hl.window_rule({ match = { class = "^(steam_app_\\d+)$" }, tag = "+games" })

-- gamestore tags
hl.window_rule({ match = { class = "^([Ss]team)$" }, tag = "+gamestore" })
hl.window_rule({ match = { title = "^([Ll]utris)$" }, tag = "+gamestore" })
hl.window_rule({ match = { class = "^(com.heroicgameslauncher.hgl)$" }, tag = "+gamestore" })

-- file-manager tags
hl.window_rule({ match = { class = "^([Tt]hunar|org.gnome.Nautilus|[Pp]cmanfm-qt)$" }, tag = "+file-manager" })
hl.window_rule({ match = { class = "^(app.drey.Warp)$" }, tag = "+file-manager" })

-- wallpaper tags
hl.window_rule({ match = { class = "^([Ww]aytrogen)$" }, tag = "+wallpaper" })

-- multimedia tags
hl.window_rule({ match = { class = "^([Aa]udacious)$" }, tag = "+multimedia" })

-- multimedia-video tags
hl.window_rule({ match = { class = "^([Mm]pv|vlc)$" }, tag = "+multimedia_video" })

-- settings tags
hl.window_rule({ match = { title = "^(ROG Control)$" }, tag = "+settings" })
hl.window_rule({ match = { class = "^(wihotspot(-gui)?)$" }, tag = "+settings" }) -- wifi hotspot
hl.window_rule({ match = { class = "^([Bb]aobab|org.gnome.[Bb]aobab)$" }, tag = "+settings" }) -- Disk usage analyzer
hl.window_rule({ match = { class = "^(gnome-disks|wihotspot(-gui)?)$" }, tag = "+settings" })
hl.window_rule({ match = { title = "(Kvantum Manager)" }, tag = "+settings" })
hl.window_rule({ match = { class = "^(file-roller|org.gnome.FileRoller)$" }, tag = "+settings" }) -- archive manager
hl.window_rule({ match = { class = "^(nm-applet|nm-connection-editor|blueman-manager)$" }, tag = "+settings" })
hl.window_rule({ match = { class = "^(pavucontrol|org.pulseaudio.pavucontrol|com.saivert.pwvucontrol)$" }, tag = "+settings" })
hl.window_rule({ match = { class = "^(qt5ct|qt6ct|[Yy]ad)$" }, tag = "+settings" })
hl.window_rule({ match = { class = "(xdg-desktop-portal-gtk)" }, tag = "+settings" })
hl.window_rule({ match = { class = "^(org.kde.polkit-kde-authentication-agent-1)$" }, tag = "+settings" })
hl.window_rule({ match = { class = "^([Rr]ofi)$" }, tag = "+settings" })

-- viewer tags
hl.window_rule({ match = { class = "^(gnome-system-monitor|org.gnome.SystemMonitor|io.missioncenter.MissionCenter)$" }, tag = "+viewer" }) -- system monitor
hl.window_rule({ match = { class = "^(evince)$" }, tag = "+viewer" }) -- document viewer
hl.window_rule({ match = { class = "^(eog|org.gnome.Loupe)$" }, tag = "+viewer" }) -- image viewer

-- popups
hl.window_rule({ match = { title = "^(Waypaper)$" }, tag = "+popup" })

-- Some special override rules
hl.window_rule({ match = { tag = "multimedia_video*" }, no_blur = true })
hl.window_rule({ match = { tag = "multimedia_video*" }, opacity = "1.0" })

-- POSITION
hl.window_rule({ match = { class = "([Tt]hunar)", title = "negative:(.*[Tt]hunar.*)" }, center = true })
hl.window_rule({ match = { title = "^(Keybindings)$" }, center = true })
hl.window_rule({ match = { class = "^(pavucontrol|org.pulseaudio.pavucontrol|com.saivert.pwvucontrol)$" }, center = true })
hl.window_rule({ match = { class = "^([Ww]hatsapp-for-linux|ZapZap|com.rtosta.zapzap)$" }, center = true })
hl.window_rule({ match = { class = "^([Ff]erdium)$" }, center = true })
hl.window_rule({ match = { title = "^(Picture-in-Picture)$" }, move = { "monitor_w * 0.72", "monitor_h * 0.07" } })

hl.window_rule({ match = { fullscreen = true }, idle_inhibit = "fullscreen" })

-- Exclude Big Picture so a tag-rule recheck cannot send it back to workspace 7.
hl.window_rule({ match = { tag = "gamestore*", title = "negative:^Steam Big Picture Mode$" }, workspace = "7" })
-- Big Picture opens on the gaming workspace.
hl.window_rule({ match = { class = "^([Ss]team)$", title = "^Steam Big Picture Mode$" }, workspace = "5" })
hl.window_rule({ match = { tag = "im*" }, workspace = "3" })
hl.window_rule({ match = { tag = "games*" }, workspace = "5" })

hl.window_rule({ match = { class = "^(Slack)$" }, workspace = "7" })
hl.window_rule({ match = { title = "Project.*" }, tag = "+project" })
hl.window_rule({ match = { tag = "project" }, workspace = "7" })

hl.window_rule({ match = { tag = "screenshare*" }, workspace = "4 silent" })
hl.window_rule({ match = { class = "^(virt-manager)$" }, workspace = "6 silent" })
hl.window_rule({ match = { class = "^(.virt-manager-wrapped)$" }, workspace = "6 silent" })
hl.window_rule({ match = { tag = "multimedia*" }, workspace = "9 silent" })

-- FLOAT
hl.window_rule({ match = { tag = "wallpaper*" }, float = true })
hl.window_rule({ match = { tag = "settings*" }, float = true })
hl.window_rule({ match = { tag = "viewer*" }, float = true })
hl.window_rule({ match = { tag = "KooL-Settings*" }, float = true })
hl.window_rule({ match = { class = "([Zz]oom|onedriver|onedriver-launcher)$" }, float = true })
hl.window_rule({ match = { class = "(org.gnome.Calculator)", title = "(Calculator)" }, float = true })
hl.window_rule({ match = { class = "^(mpv|com.github.rafostar.Clapper)$" }, float = true })
hl.window_rule({ match = { class = "^([Qq]alculate-gtk)$" }, float = true })
hl.window_rule({ match = { class = "^([Ff]erdium)$" }, float = true })
hl.window_rule({ match = { title = "^(Picture-in-Picture)$" }, float = true })

hl.window_rule({ match = { title = "^(Authentication Required)$" }, float = true })
hl.window_rule({ match = { title = "^(Authentication Required)$" }, center = true })
hl.window_rule({ match = { class = "(codium|codium-url-handler|VSCodium)", title = "negative:(.*codium.*|.*VSCodium.*)" }, float = true })
hl.window_rule({ match = { class = "^(com.heroicgameslauncher.hgl)$", title = "negative:(Heroic Games Launcher)" }, float = true })
hl.window_rule({ match = { class = "^([Ss]team)$", title = "negative:^([Ss]team)$" }, float = true })
hl.window_rule({ match = { class = "([Tt]hunar)", title = "negative:(.*[Tt]hunar.*)" }, float = true })

hl.window_rule({ match = { title = "^(Add Folder to Workspace)$" }, float = true })
hl.window_rule({ match = { title = "^(Add Folder to Workspace)$" }, size = { "monitor_w * 0.7", "monitor_h * 0.6" } })
hl.window_rule({ match = { title = "^(Add Folder to Workspace)$" }, center = true })

hl.window_rule({ match = { title = "^(Save As)$" }, float = true })
hl.window_rule({ match = { title = "^(Save As)$" }, size = { "monitor_w * 0.7", "monitor_h * 0.6" } })
hl.window_rule({ match = { title = "^(Save As)$" }, center = true })

hl.window_rule({ match = { title = "^(Save File)$" }, float = true })
hl.window_rule({ match = { title = "^(Save File)$" }, size = { "monitor_w * 0.7", "monitor_h * 0.6" } })
hl.window_rule({ match = { title = "^(Save File)$" }, center = true })

hl.window_rule({ match = { tag = "popup" }, float = true })
hl.window_rule({ match = { tag = "popup" }, size = { "monitor_w * 0.7", "monitor_h * 0.6" } })
hl.window_rule({ match = { tag = "popup" }, center = true })

-- Vivaldi popups
hl.window_rule({ match = { class = "^(vivaldi-stable)$", title = "negative:^(Vivaldi - Vivaldi|Start Page - Vivaldi)$" }, float = true })
hl.window_rule({ match = { class = "^(vivaldi-stable)$", title = "negative:^(Vivaldi - Vivaldi|Start Page - Vivaldi)$" }, size = { "monitor_w * 0.7", "monitor_h * 0.6" } })
hl.window_rule({ match = { class = "^(vivaldi-stable)$", title = "negative:^(Vivaldi - Vivaldi|Start Page - Vivaldi)$" }, center = true })

hl.window_rule({ match = { initial_title = "(Open Files)" }, float = true })
hl.window_rule({ match = { initial_title = "(Open Files)" }, size = { "monitor_w * 0.7", "monitor_h * 0.6" } })

hl.window_rule({ match = { title = "^(SDDM Background)$" }, float = true }) -- KooL's Dots YAD for setting SDDM background
hl.window_rule({ match = { title = "^(SDDM Background)$" }, center = true }) -- KooL's Dots YAD for setting SDDM background
hl.window_rule({ match = { title = "^(SDDM Background)$" }, size = { "monitor_w * 0.16", "monitor_h * 0.12" } }) -- KooL's Dots YAD for setting SDDM background
-- END of float popups and dialogue #######

-- OPACITY
hl.window_rule({ match = { tag = "browser*" }, opacity = "1.0 1.1" })
hl.window_rule({ match = { tag = "projects*" }, opacity = "0.9 0.8" })
hl.window_rule({ match = { tag = "im*" }, opacity = "0.94 0.86" })
hl.window_rule({ match = { tag = "multimedia*" }, opacity = "0.94 0.86" })
hl.window_rule({ match = { tag = "file-manager*" }, opacity = "0.9 0.8" })
hl.window_rule({ match = { tag = "terminal*" }, opacity = "0.95 0.9" })
hl.window_rule({ match = { tag = "settings*" }, opacity = "0.8 0.7" })
hl.window_rule({ match = { tag = "viewer*" }, opacity = "0.82 0.75" })
hl.window_rule({ match = { tag = "wallpaper*" }, opacity = "0.9 0.7" })
hl.window_rule({ match = { class = "^(gedit|org.gnome.TextEditor|mousepad)$" }, opacity = "0.8 0.7" })
hl.window_rule({ match = { class = "^(deluge)$" }, opacity = "0.9 0.8" })
hl.window_rule({ match = { class = "^(im.riot.Riot)$" }, opacity = "0.9 0.8" }) -- Element matrix client
hl.window_rule({ match = { class = "^(seahorse)$" }, opacity = "0.9 0.8" }) -- gnome-keyring gui
hl.window_rule({ match = { title = "^(Picture-in-Picture)$" }, opacity = "0.95 0.75" })

-- SIZE
hl.window_rule({ match = { tag = "wallpaper*" }, size = { "monitor_w * 0.7", "monitor_h * 0.7" } })
hl.window_rule({ match = { tag = "settings*" }, size = { "monitor_w * 0.7", "monitor_h * 0.7" } })
hl.window_rule({ match = { class = "^([Ww]hatsapp-for-linux|ZapZap|com.rtosta.zapzap)$" }, size = { "monitor_w * 0.6", "monitor_h * 0.7" } })
hl.window_rule({ match = { class = "^([Ff]erdium)$" }, size = { "monitor_w * 0.6", "monitor_h * 0.7" } })

-- PINNING
hl.window_rule({ match = { title = "^(Picture-in-Picture)$" }, pin = true })

hl.window_rule({ match = { title = "^(Picture-in-Picture)$" }, keep_aspect_ratio = true })

-- BLUR & FULLSCREEN
hl.window_rule({ match = { tag = "games*" }, no_blur = true })

-- LAYER RULES
hl.layer_rule({ match = { namespace = "rofi" }, no_anim = true })
hl.layer_rule({ match = { namespace = "notifications" }, blur = true })

hl.layer_rule({ match = { namespace = "sideleft.*" }, animation = "slide left" })
hl.layer_rule({ match = { namespace = "sideright.*" }, animation = "slide right" })

-- Launchers need to be FAST
hl.layer_rule({ match = { namespace = "gtk4-layer-shell" }, no_anim = true })
