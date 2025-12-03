local wibox = require("wibox")
local gears = require("gears")
local awful = require("awful")

-- Volume control using `amixer`

local M = {}

local opts = {
	icons = {
		mute = "󰝟",
		low = "󰕿",
		medium = "󰖀",
		high = "󰕾",
	},

	volume_step = "5",
}

local volume_widget = wibox.widget.textbox()

local function update_volume()
	awful.spawn.easy_async_with_shell("amixer get Master", function(stdout)
		local line = stdout:match("Front Left:[^\n]*")

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

		if not is_mute then
			if volume <= 25 then
				icon = opts.icons.low
			elseif volume <= 55 then
				icon = opts.icons.medium
			else
				icon = opts.icons.high
			end
		else
			icon = opts.icons.mute
		end

		volume_widget.text = string.format("%s %s%%", icon, volume_text)
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
