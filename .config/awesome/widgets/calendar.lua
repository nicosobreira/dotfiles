local wibox = require("wibox")
local awful = require("awful")
local gears = require("gears")

local ui_utils = require("ui.utils")
local settings = require("settings")

local calendar = wibox.widget({
	{
		id = "icon",
		font = ui_utils.font_resize(12),
		markup = " ",
		align = "center",
		valing = "center",
		widget = wibox.widget.textbox,
	},
	{
		id = "date",
		format = "%d/%m %a",
		refresh = 600,
		widget = wibox.widget.textclock,
	},
	spacing = settings.spacing,
	layout = wibox.layout.fixed.horizontal,
})

-- popup calendar
local calendar_popup = awful.widget.calendar_popup.month()

-- toggle popup on click
calendar:buttons(gears.table.join(
	awful.button({}, 1, function()
		calendar_popup:toggle()
	end),

	awful.button({}, 4, function()
		calendar_popup:call_calendar(1)
	end),

	awful.button({}, 5, function()
		calendar_popup:call_calendar(-1)
	end)
))

-- attach popup to widget position
calendar_popup:attach(calendar, "tr")

return calendar
