-- Hyprland 0.55+ Lua configuration.
-- The modules mirror the previous Hyprlang files so each area stays easy to edit.

require("environment")
require("monitor")

hl.config({
    cursor = {
        no_hardware_cursors = true,
    },

    general = {
        gaps_in = 2,
        gaps_out = 5,
        border_size = 0,
        col = {
            inactive_border = "rgba(45475a88)",
            active_border = "rgba(45475a88)",
        },
        resize_on_border = false,
        allow_tearing = true,
        layout = "dwindle",
    },

    decoration = {
        rounding = 22,
        blur = {
            enabled = true,
            size = 3,
            passes = 2,
            vibrancy = 0.1696,
        },
    },

    animations = {
        enabled = true,
    },

    dwindle = {
        preserve_split = true,
    },

    master = {
        new_status = "master",
    },

    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo = true,
        vrr = 0,
    },

    input = {
        kb_layout = "us",
        kb_variant = "",
        kb_model = "",
        kb_options = "caps:swapescape",
        kb_rules = "",
        follow_mouse = 1,
        sensitivity = 0,
        touchpad = {
            natural_scroll = false,
        },
    },
})

hl.curve("myBezier", {
    type = "bezier",
    points = {
        { 0.05, 0.9 },
        { 0.1, 1.05 },
    },
})

hl.animation({ leaf = "windows", enabled = true, speed = 7, bezier = "myBezier" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 7, bezier = "default", style = "popin 80%" })
hl.animation({ leaf = "border", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 8, bezier = "default" })
hl.animation({ leaf = "fade", enabled = true, speed = 7, bezier = "default" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 6, bezier = "default" })

hl.device({
    name = "epic-mouse-v1",
    sensitivity = -0.5,
})

require("windowrule")
require("autostart")
require("bind")
