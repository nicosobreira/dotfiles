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
	awful.spawn.easy_async_with_shell("wpctl get-volume @DEFAULT_AUDIO_SINK@", function(stdout)
		-- stdout = "Volume: 0.42 [MUTED]"
		-- stdout = "Volume: 0.94"

		local volume_text = stdout:match("Volume: *([%d%.]+)")

		if volume_text == nil then
			volume_text = "0"
		end

		local volume = tonumber(volume_text) * 100

		local is_mute = false
		if stdout:match("%[(.-)%]") then
			is_mute = true
		end

		local icon = opts.icons.medium

		if is_mute then
			icon = opts.icons.mute
		else
			icon = indicator.get_icon(volume, 30, 60, opts.icons)
		end

		volume_widget.icon.markup = icon

		volume_widget.level.markup = volume .. "%"
	end)
end

local function unmute()
	local command = "wpctl set-mute @DEFAULT_AUDIO_SINK@ 0"

	awful.spawn(command, false)
end

function M.toggle()
	local command = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"

	awful.spawn(command, false)

	update_volume()
end

function M.increase()
	unmute()

	local command = "wpctl set-volume @DEFAULT_AUDIO_SINK@ " .. opts.volume_step .. "%+"
	awful.spawn(command, false)

	update_volume()
end

function M.decrease()
	unmute()

	local command = "wpctl set-volume @DEFAULT_AUDIO_SINK@ " .. opts.volume_step .. "%-"
	awful.spawn(command, false)

	update_volume()
end

volume_widget:buttons(awful.util.table.join(awful.button({}, 1, function()
	awful.spawn("pwvucontrol --tab=1", {
		floating = true,
		ontop = true,
		placement = awful.placement.top_right,
	}, function(c)
		local wa = c.screen.workarea

		c:geometry({
			width = math.floor(wa.width / 2),
			height = math.floor(wa.height / 2),
		})
	end)
end)))

M.widget = volume_widget

-- Initial update
update_volume()

return M
