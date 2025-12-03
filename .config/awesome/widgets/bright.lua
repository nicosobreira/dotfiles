local wibox = require("wibox")
local gears = require("gears")
local awful = require("awful")

-- Brightness control using `light`

local M = {}

local backlight = "intel_backlight"

local opts = {
	icon = "󰃟",
	bright_step = "5",
	bright_current_file = "/sys/class/backlight/" .. backlight .. "/brightness",
	bright_max_file = "/sys/class/backlight/" .. backlight .. "/max_brightness",
}

assert(gears.filesystem.file_readable(opts.bright_current_file))
assert(gears.filesystem.file_readable(opts.bright_max_file))

local bright_widget = wibox.widget.textbox()

local function read_file(file_path)
	local file = io.open(file_path, "r")

	if not file then
		return nil
	end

	return file:read()
end

local function update_bright()
	local bright_current = tonumber(read_file(opts.bright_current_file))

	local bright_max = tonumber(read_file(opts.bright_max_file))

	local percentage = math.ceil((bright_current / bright_max) * 100)

	bright_widget.text = string.format("%s %d%%", opts.icon, percentage)
end

function M.increase()
	awful.spawn("light -A " .. opts.bright_step)
	update_bright()
end

function M.decrease()
	awful.spawn("light -U " .. opts.bright_step)
	update_bright()
end

M.widget = bright_widget

-- Initial update
update_bright()

return M
