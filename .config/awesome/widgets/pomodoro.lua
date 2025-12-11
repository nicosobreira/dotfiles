local wibox = require("wibox")
local beautiful = require("beautiful")

local settings = require("settings")
local ui_utils = require("ui.utils")

local opts = {
	icons = {
		default = " ",
		running = " ",
	},
	colors = {
		pomo = beautiful.colors.red,
		pause = beautiful.colors.blue,
		rest = beautiful.colors.green,
		long_rest = beautiful.colors.yellow,
	},
}

local M = {}

M.widget = wibox.widget({
	{
		id = "icon",
		markup = ui_utils.markup_with_color(opts.icons.default, opts.colors.pomo),
		widget = wibox.widget.textbox,
	},
	{
		id = "timer",
		text = "00:00",
		widget = wibox.widget.textbox,
	},
	spacing = settings.spacing,
	layout = wibox.layout.fixed.horizontal,
})

return M
