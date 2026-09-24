local terminal = "ghostty"
local file_manager = "dolphin"
local menu = "caelestia shell drawers toggle launcher"
local browser = "uwsm app -- app.zen_browser.zen"
local main_mod = "SUPER"

hl.bind(main_mod .. " + Q", hl.dsp.exec_cmd(terminal))
hl.bind(main_mod .. " + W", hl.dsp.window.close())
hl.bind(main_mod .. " + F", hl.dsp.exec_cmd(browser))
hl.bind(main_mod .. " + M", hl.dsp.exit())
hl.bind(main_mod .. " + E", hl.dsp.exec_cmd(file_manager))
hl.bind(main_mod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(main_mod .. " + T", hl.dsp.exec_cmd("caelestia emoji -p"))
hl.bind(main_mod .. " + space", hl.dsp.exec_cmd(menu))
hl.bind("SUPER + SHIFT + space", hl.dsp.exec_cmd("ulauncher-toggle"))
hl.bind("SUPER + SHIFT + Z", hl.dsp.window.pseudo())
hl.bind(main_mod .. " + J", hl.dsp.layout("togglesplit"))
hl.bind(main_mod .. " + X", hl.dsp.exec_cmd("grimblast copy area"))
hl.bind("SUPER + C", hl.dsp.exec_cmd("kitty --class clipse -e clipse"))
hl.bind("SUPER + SHIFT + C", hl.dsp.exec_cmd("/home/archmo/Scripts/caffeine.zsh"))
hl.bind(main_mod .. " + N", hl.dsp.exec_cmd("uwsm app -- nwg-drawer"))
hl.bind(main_mod .. " + G", hl.dsp.exec_cmd("caelestia shell lock lock"))
hl.bind("SUPER + SHIFT + R", hl.dsp.exec_cmd("sh -c 'pkill -f \"qs -c caelestia\"; sleep 1; uwsm app -- caelestia shell -d'"))
hl.bind(main_mod .. " + U", hl.dsp.exec_cmd("uwsm app -- sunshine"))
hl.bind(main_mod .. " + B", hl.dsp.exec_cmd("zsh /home/archmo/.config/hypr/bluetooth-toggle.zsh"))
hl.bind("SUPER + SHIFT + B", hl.dsp.exec_cmd("/home/archmo/Scripts/connect.zsh"))

local directions = {
	H = "left",
	L = "right",
	K = "up",
	J = "down",
}

for key, direction in pairs(directions) do
	hl.bind(main_mod .. " + " .. key, hl.dsp.focus({ direction = direction }))
	hl.bind("SUPER + ALT + " .. key, hl.dsp.window.move({ direction = direction }))
	hl.bind("SUPER + SHIFT + " .. key, hl.dsp.window.swap({ direction = direction }))
end

hl.bind("SUPER + SHIFT + M", hl.dsp.window.fullscreen({ mode = 1, action = "toggle" }))

for workspace = 1, 10 do
	local key = workspace % 10
	hl.bind(main_mod .. " + " .. key, hl.dsp.focus({ workspace = workspace }))
	hl.bind(main_mod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = workspace }))
end

hl.bind(main_mod .. " + S", hl.dsp.workspace.toggle_special("spotify"))
hl.bind(main_mod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:spotify" }))
hl.workspace_rule({
	workspace = "special:spotify",
	on_created_empty = "spotify-launcher",
})

hl.bind(main_mod .. " + O", hl.dsp.workspace.toggle_special("obsidian"))
hl.bind(main_mod .. " + SHIFT + O", hl.dsp.window.move({ workspace = "special:obsidian" }))
hl.workspace_rule({
	workspace = "special:obsidian",
	on_created_empty = "md.obsidian.Obsidian",
})

hl.bind(main_mod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(main_mod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(main_mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(main_mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"), { repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { repeating = true })

for _, player in ipairs({ "spotify", "cider", "ncspot" }) do
	hl.bind("XF86AudioMute", hl.dsp.exec_cmd("playerctl --player=" .. player .. " play-pause"), { locked = true })
	hl.bind(main_mod .. " + XF86AudioRaiseVolume", hl.dsp.exec_cmd("playerctl --player=" .. player .. " volume 0.1+"), {
		locked = true,
		repeating = true,
	})
	hl.bind(main_mod .. " + XF86AudioLowerVolume", hl.dsp.exec_cmd("playerctl --player=" .. player .. " volume 0.1-"), {
		locked = true,
		repeating = true,
	})
end

hl.bind("SUPER + ALT + R", hl.dsp.submap("resize"))
hl.define_submap("resize", "reset", function()
	hl.bind("L", hl.dsp.window.resize({ x = 40, y = 0, relative = true }), { repeating = true })
	hl.bind("H", hl.dsp.window.resize({ x = -40, y = 0, relative = true }), { repeating = true })
	hl.bind("K", hl.dsp.window.resize({ x = 0, y = -40, relative = true }), { repeating = true })
	hl.bind("J", hl.dsp.window.resize({ x = 0, y = 40, relative = true }), { repeating = true })
end)
