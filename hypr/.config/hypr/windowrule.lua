hl.window_rule({
	name = "picture-in-picture",
	match = { title = "(Picture-in-Picture)" },
	float = true,
	no_initial_focus = true,
	size = { 600, 400 },
	move = { 10, 10 },
	pin = true,
	animation = "slide left",
})

hl.window_rule({
	name = "zathura-opacity",
	match = { class = ".*^(org.pwmt.zathura)$" },
	opacity = "0.9 0.9",
})

hl.window_rule({
	name = "clipse",
	match = { class = "^clipse$" },
	float = true,
	size = { 622, 652 },
	stay_focused = true,
})

hl.window_rule({
	name = "ulauncher",
	match = {
		title = "negative:Ulauncher Preferences",
		class = "ulauncher",
	},
	move = {
		"((monitor_w)-window_w)*0.5",
		"((monitor_h)-window_h)*0.3",
	},
	border_size = 3,
	border_color = "rgba(fbfbfb35)",
	stay_focused = true,
	no_blur = true,
})

hl.window_rule({
	name = "suppress-maximize",
	match = { class = ".*" },
	suppress_event = "maximize",
})
