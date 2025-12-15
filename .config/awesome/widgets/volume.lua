-- Volume control using `amixer`

local awful = require("awful")
local beautiful = require("beautiful")

local indicator = require("widgets.templates.indicator")

local M = {}

local opts = {
	icons = {
		mute = "󰝟 ",
		low = "󰕿 ",
		medium = "󰖀 ",
		high = "󰕾 ",
	},

	colors = {
		low = beautiful.colors.red,
		medium = beautiful.colors.yellow,
		high = beautiful.colors.green,
	},

	volume_step = "3",
}

local volume_widget = indicator.new()

local function update_volume()
	awful.spawn.easy_async_with_shell("amixer get Master", function(stdout)
		local line = stdout:match("Front Left:[^\n]*") or ""

		local volume_text = line:match("%[(%d+)%%%]")

		if volume_text == nil then
			volume_text = "0"
		end

		local volume = tonumber(volume_text)

		-- "on" or "off"
		local is_mute = false
		if line:match("%[off%]") then
			is_mute = true
		end

		local icon = opts.icons.medium

		if is_mute then
			icon = opts.icons.mute
		else
			icon = indicator.get_icon(volume, 30, 60, opts.icons)
		end

		volume_widget.icon.markup = icon

		volume_widget.level.markup = volume_text .. "%"
	end)
end

-- Initial update
update_volume()

function M.toggle()
	awful.spawn("amixer set Master toggle", false)
	update_volume()
end

function M.increase()
	awful.spawn.with_shell("amixer set Master unmute && amixer set Master " .. opts.volume_step .. "%+", false)
	update_volume()
end

function M.decrease()
	awful.spawn.with_shell("amixer set Master unmute && amixer set Master " .. opts.volume_step .. "%-", false)
	update_volume()
end

M.widget = volume_widget

return M
