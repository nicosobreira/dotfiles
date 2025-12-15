-- Brightness control using `light`

local gears = require("gears")
local awful = require("awful")
local beautiful = require("beautiful")

local ui_utils = require("ui.utils")

local indicator = require("widgets.templates.indicator")

local function read_file(file_path)
	local file = io.open(file_path, "r")

	if not file then
		return nil
	end

	return file:read()
end

local M = {}

local opts = {
	icon = "󰃟 ",
	color = beautiful.colors.white,
	bright_step = "5",
	backlight = "intel_backlight",
}

local bright_current_path = "/sys/class/backlight/" .. opts.backlight .. "/brightness"

local bright_max_path = "/sys/class/backlight/" .. opts.backlight .. "/max_brightness"

assert(gears.filesystem.file_readable(bright_current_path))
assert(gears.filesystem.file_readable(bright_max_path))

local bright_widget = indicator.new()

bright_widget.icon.markup = ui_utils.markup_with_color(opts.icon, opts.color)

local function update_bright()
	local bright_current = tonumber(read_file(bright_current_path))

	local bright_max = tonumber(read_file(bright_max_path))

	local percentage = math.ceil((bright_current / bright_max) * 100)

	bright_widget.level.markup = percentage .. "%"
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
