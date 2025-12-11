local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")

local settings = require("settings")
local ui_utils = require("ui.utils")

-- Default options
local opts = {
	bat = "BAT1",
	timeout = 30,

	icons = {
		low = "󱊡 ",
		medium = "󱊢 ",
		high = "󱊣 ",
	},

	colors = {
		low = beautiful.colors.red,
		medium = beautiful.colors.yellow,
		high = beautiful.colors.green,
	},
}

local battery = wibox.widget({
	{
		id = "icon",
		markup = opts.icons.high,
		-- font = ui_utils.font_resize(12),
		widget = wibox.widget.textbox,
	},
	{
		id = "level",
		markup = "100%",
		widget = wibox.widget.textbox,
	},
	spacing = settings.spacing,
	layout = wibox.layout.fixed.horizontal,
})

local function get_icon(level, low_level, medium_level)
	if level <= low_level then
		return ui_utils.markup_with_color(opts.icons.low, opts.colors.low)
	elseif level <= medium_level then
		return ui_utils.markup_with_color(opts.icons.medium, opts.colors.medium)
	else
		return ui_utils.markup_with_color(opts.icons.high, opts.colors.high)
	end
end

local function update_battery()
	local path = string.format("/sys/class/power_supply/%s/capacity", opts.bat)

	assert(gears.filesystem.file_readable(path))

	local file = io.open(path, "r")

	if not file then
		return nil
	end

	local level_text = file:read()

	file:close()

	local level = tonumber(level_text)

	battery.icon.markup = get_icon(level, 30, 60)

	battery.level.text = level_text .. "%"
end

gears.timer({
	timeout = opts.timeout,
	call_now = true,
	autostart = true,
	callback = update_battery,
})

return battery
