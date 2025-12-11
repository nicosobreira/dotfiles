-- Volume control using `amixer`

local wibox = require("wibox")
local awful = require("awful")
local beautiful = require("beautiful")

local settings = require("settings")
local ui_utils = require("ui.utils")

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

local volume_widget = wibox.widget({
	{
		id = "icon",
		markup = opts.icons.high,
		widget = wibox.widget.textbox,
	},
	{
		id = "text",
		markup = "100%",
		widget = wibox.widget.textbox,
	},
	spacing = settings.spacing,
	layout = wibox.layout.fixed.horizontal,
})

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
			icon = get_icon(volume)
		end

		volume_widget.icon.markup = icon

		volume_widget.text.markup = volume_text .. "%"
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
