local wibox = require("wibox")
local gears = require("gears")
local awful = require("awful")

local function set_timer(battery, opts)
	local path = string.format("/sys/class/power_supply/%s/capacity", opts.bat)
	assert(gears.filesystem.file_readable(path))

	gears.timer({
		timeout = opts.timeout,
		call_now = true,
		autostart = true,
		callback = function()
			local file = io.open(path, "r")

			battery.battery = file:read()

			file:close()
		end,
	})
end

local M = {}

--- Default options
M.opts = {
	bat = "BAT1",
	timeout = 10,
}

---@param opts table
function M.setup(opts)
	opts = opts or {}
	opts.bat = opts.bat or M.opts.bat
	opts.timeout = opts.timeout or M.opts.timeout

	local battery = wibox.widget({
		text = "100%",
		widget = wibox.widget.textbox,
		set_battery = function(self, value)
			self.text = tonumber(value) .. "%"
		end,
	})

	set_timer(battery, opts)

	return battery
end

return M
