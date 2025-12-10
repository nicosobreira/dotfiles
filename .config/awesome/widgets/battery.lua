local wibox = require("wibox")
local gears = require("gears")

-- Default options
local opts = {
	bat = "BAT1",
	timeout = 30,

	icons = {
		low = "󱊡 ",
		medium = "󱊢 ",
		high = "󱊣 ",
	},
}

local battery = wibox.widget({
	{
		id = "icon",
		text = opts.icons.high,
		-- font = ui_utils.font_resize(12),
		widget = wibox.widget.textbox,
	},
	{
		id = "level",
		text = "100%",
		widget = wibox.widget.textbox,
	},
	spacing = 5,
	layout = wibox.layout.fixed.horizontal,
})

local function update_battery()
	local path = string.format("/sys/class/power_supply/%s/capacity", opts.bat)
	assert(gears.filesystem.file_readable(path))

	local file = io.open(path, "r")

	if not file then
		return nil
	end

	local level = file:read()

	file:close()

	local number_level = tonumber(level)

	if number_level <= 30 then
		battery.icon.text = opts.icons.low
	elseif number_level <= 60 then
		battery.icon.text = opts.icons.medium
	else
		battery.icon.text = opts.icons.high
	end

	battery.level.text = number_level .. "%"
end

gears.timer({
	timeout = opts.timeout,
	call_now = true,
	autostart = true,
	callback = update_battery,
})

return battery
