local gears = require("gears")
local beautiful = require("beautiful")

local indicator = require("widgets.templates.indicator")

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

local battery = indicator.new()

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

	battery.icon.markup = indicator.get_icon_color(level, 30, 60, opts.icons, opts.colors)

	battery.level.text = level_text .. "%"
end

gears.timer({
	timeout = opts.timeout,
	call_now = true,
	autostart = true,
	callback = update_battery,
})

return battery
