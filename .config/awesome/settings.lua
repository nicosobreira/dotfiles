return {
	modkey = "Mod4",
	increase_window_factor = 0.05,

	terminal = os.getenv("TERMINAL") or "kitty",
	editor = os.getenv("EDITOR") or "nvim",
	browser = os.getenv("BROWSER") or "brave",

	theme_name = "xresources",
}
