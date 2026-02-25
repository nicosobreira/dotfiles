local gears = require("gears")
local beautiful = require("beautiful")
local naughty = require("naughty")

local indicator = require("widgets.templates.indicator")

local opts = {
	path = "/sys/class/power_supply",
	bat = "BAT1",
	timeout = 30,

	levels = {
		low = 30,
		medium = 60,
	},

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

local function check_battery_file()
	local file_path = string.format("%s/%s/capacity", opts.path, opts.bat)

	if gears.filesystem.file_readable(file_path) then
		return true
	end

	naughty.notify({
		preset = naughty.config.presets.critical,
		title = "ERROR: widgets.battery",
		text = string.format('There is no file "capacity" in "%s"', file_path),
	})

	return false
end

local function battery_warning(level)
	if level > opts.levels.low then
		return
	end

	local message = "Battery is Low"

	naughty.notify({
		preset = naughty.config.presets.normal,
		position = "top_right",
		title = message,
	})
end

local function update_battery()
	local file_path = string.format("%s/%s/capacity", opts.path, opts.bat)

	local file = io.open(file_path)

	if not file then
		return nil
	end

	local level_text = file:read()

	file:close()

	local level = tonumber(level_text)

	-- stylua: ignore
	battery.icon.markup = indicator.get_icon_color(
		level,
		opts.levels.low,
		opts.levels.medium,
		opts.icons,
		opts.colors
	)

	battery.level.text = level_text .. "%"

	battery_warning(level)
end

---

if not check_battery_file() then
	return battery
end

gears.timer({
	timeout = opts.timeout,
	call_now = true,
	autostart = true,
	callback = update_battery,
})

return battery
