local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

return {
	modkey = "Mod4",
	increase_window_factor = 0.05,
	spacing = dpi(0),

	terminal = os.getenv("TERMINAL") or "xterm",
	editor = os.getenv("EDITOR") or "vim",
	browser = os.getenv("BROWSER") or "brave",

	theme_name = "xresources",

	tags = { " ", "󰖟 ", "󰺷 ", " ", " " },
}
