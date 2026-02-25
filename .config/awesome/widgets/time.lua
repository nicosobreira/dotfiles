local wibox = require("wibox")

local ui_utils = require("ui.utils")
local settings = require("settings")

local time = wibox.widget({
	{
		id = "icon",
		font = ui_utils.font_resize(12),
		markup = " ",
		align = "center",
		valing = "center",
		widget = wibox.widget.textbox,
	},
	{
		id = "date",
		format = "%H:%M",
		widget = wibox.widget.textclock,
	},
	spacing = settings.spacing,
	layout = wibox.layout.fixed.horizontal,
})

return time
