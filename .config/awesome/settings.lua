local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

return {
	modkey = "Mod4",
	increase_window_factor = 0.05,
	spacing = dpi(0),

	-- FIX: `os.getenv("TERMINAL") doesn't work?
	terminal = os.getenv("TERMINAL") or "kitty",
	editor = os.getenv("EDITOR") or "nvim",
	browser = os.getenv("BROWSER") or "brave",

	theme_name = "xresources",

	tags = { " ", "󰖟 ", "󰺷 ", " ", " " },
}
