-- hypr-seam config (Lua)
--
-- Based on examples/seam.lua from the hypr-seam plugin repo
-- (/home/archmo/Projects/hypr-seam, on main). Required from hyprland.lua
-- via `require("seam")`, so this file is live. The plugin .so itself is
-- loaded at startup from autostart.lua (a local build, not yet released
-- via hyprpm) -- that load must happen before this file's hl.config() call
-- runs, or these keys won't be registered yet.
--
-- Requires `decoration.rounding = 0` in your Hyprland config: this plugin
-- fully replaces native corner rendering, so leaving native rounding on
-- will double up with (or fight) hypr-seam's own rounding. Already set in
-- hyprland.lua.

hl.config({
	plugin = {
		seam = {
			-- Uniform base corner radius used for any corner that doesn't
			-- have its own rounding_* override below. This is the radius
			-- windows render at when the seam effect isn't flattening them.
			rounding = 22,

			-- Per-corner base radius overrides. Each one falls back to
			-- `rounding` above when left unset, so you only need to set the
			-- corners you want to differ. Commented out here since "unset"
			-- has no literal Lua value — uncomment and set a number to
			-- override a specific corner.
			-- rounding_topleft = 22,
			-- rounding_topright = 22,
			-- rounding_bottomleft = 22,
			-- rounding_bottomright = 22,

			-- Squircle exponent for the corner curve shape. 2.0 matches a
			-- regular rounded-rectangle curve (Hyprland's native look).
			-- Raise it for a more squared-off "squircle" corner.
			rounding_power = 2.0,

			-- Global master switch for the seam effect. When false, windows
			-- just render with ordinary per-corner rounding and nothing
			-- ever flattens, regardless of adjacency.
			enabled = true,

			-- Radius a corner collapses to once it's flagged as touching a
			-- neighboring tiled window (a book-seam corner instead of a
			-- fully rounded one).
			seam_radius = 2,

			-- Maximum gap, in pixels, between two window edges that still
			-- counts as "touching" for seam purposes. Covers gaps_in plus
			-- floating-point/scale slop.
			tolerance = 6,

			-- Eases a corner's radius between its base and seam values
			-- instead of snapping instantly when adjacency changes.
			animate = true,

			-- Duration, in milliseconds, of that easing transition.
			animation_speed = 3000,

			-- Name of a bezier curve already registered via hl.curve(...)
			-- (or a `bezier =` line in a plain .conf config) to drive the
			-- easing above. "default" is Hyprland's built-in curve.
			animation_curve = "default",

			-- Off by default. Some GPU-accelerated apps (Firefox, Zen
			-- Browser) draw their whole window into a covering subsurface
			-- that paints square on top of the correctly-rounded main
			-- surface, so their corners look unrounded. Turning this on
			-- rounds that subsurface too, at just the corners it shares
			-- with the window (an embedded video in the middle of a page
			-- stays square, as it should). Not yet tested against every
			-- app that uses this pattern (e.g. mpv) -- enable per taste.
			force_round_risky_surfaces = true,
		},
	},
})

-- Per-app rules (hl.plugin.seam.rule)
--
-- Hyprland's plugin API has no hook into the native windowrulev2 engine, so
-- hypr-seam parses its own rules using the same class:/title: match syntax
-- as windowrule2. hl.plugin.seam.rule(...) accepts either the exact string
-- a `seamrule = ...` config line would take, or an equivalent table.

-- String form: opt a window out of the seam effect even if
-- plugin:seam:enabled is true above.
-- hl.plugin.seam.rule("seam 0, class:^(foot)$")

-- Table form: give a specific app its own per-corner base rounding
-- (top-left, top-right, bottom-left, bottom-right), independent of the
-- global `rounding`/`rounding_*` values set above.
-- hl.plugin.seam.rule({ class = "^(kitty)$", rounding = { 4, 4, 22, 22 } })

-- Table form: force a window to never flatten (seam = false). This config
-- already has a picture-in-picture windowrule in windowrule.lua
-- (title = "(Picture-in-Picture)", float = true) — this is the hypr-seam
-- equivalent, so that floating-adjacent PiP window never visually merges
-- with whatever tiled window it happens to sit next to.
-- hl.plugin.seam.rule({ title = "^Picture-in-Picture$", seam = false })
