local awful = require("awful")

local indicator = require("widgets.templates.indicator")

local M = {}

local opts = {
	levels = {
		low = 30,
		medium = 60,
	},

	icons = {
		mute = "󰝟 ",
		low = "󰕿 ",
		medium = "󰖀 ",
		high = "󰕾 ",
	},

	volume_step = "3",
	max_volume = "1.0",

	mixer_cmd = "pwvucontrol --tab=1",
}

local volume_widget = indicator.new()

-------------------------------------------------
-- UI UPDATE
-------------------------------------------------

local function update_ui(volume, mute)
	local icon = ""

	if mute then
		icon = opts.icons.mute
	else
		-- stylua: ignore
		icon = indicator.get_icon(
			volume,
			opts.levels.low,
			opts.levels.medium,
			opts.icons
		)
	end

	volume_widget.icon.markup = icon
	volume_widget.level.markup = volume .. "%"
end

local function update()
	awful.spawn.easy_async_with_shell("wpctl get-volume @DEFAULT_AUDIO_SINK@", function(stdout)
		-- stdout = "Volume: 0.42 [MUTED]"
		-- stdout = "Volume: 0.94"

		local volume_text = stdout:match("Volume: *([%d%.]+)")

		if volume_text == nil then
			volume_text = "0"
		end

		local volume = tonumber(volume_text) * 100

		local mute = stdout:match("%[MUTED%]") ~= nil

		update_ui(volume, mute)
	end)
end

-------------------------------------------------
-- ACTIONS (wpctl control)
-------------------------------------------------

local function unmute()
	local command = "wpctl set-mute @DEFAULT_AUDIO_SINK@ 0"

	awful.spawn(command, false)
end

function M.toggle()
	awful.spawn("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle", false)
	update()
end

function M.increase()
	unmute()
	awful.spawn("wpctl set-volume @DEFAULT_AUDIO_SINK@ " .. opts.volume_step .. "%+ --limit " .. opts.max_volume, false)

	update()
end

function M.decrease()
	unmute()
	awful.spawn("wpctl set-volume @DEFAULT_AUDIO_SINK@ " .. opts.volume_step .. "%- --limit " .. opts.max_volume, false)

	update()
end

-------------------------------------------------
-- BUTTONS
-------------------------------------------------

local function open_mixer()
	awful.spawn(opts.mixer_cmd, {
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
end

volume_widget:buttons(
	awful.util.table.join(
		awful.button({}, 1, open_mixer),
		awful.button({}, 4, M.increase),
		awful.button({}, 5, M.decrease),
		awful.button({}, 3, M.toggle)
	)
)

M.widget = volume_widget

update()

return M
