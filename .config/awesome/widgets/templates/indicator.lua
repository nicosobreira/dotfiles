local wibox = require("wibox")

local ui_utils = require("ui.utils")
local settings = require("settings")

local M = {}

function M.new()
	local bigger_font_size = ui_utils.font_get_size() + 2
	local bigger_font = ui_utils.font_resize(bigger_font_size)

	return wibox.widget({
		{
			id = "icon",
			widget = wibox.widget.textbox,
			font = bigger_font,
			markup = "icon",
			align = "center",
			valing = "center",
		},
		{
			id = "level",
			widget = wibox.widget.textbox,
			markup = "level",
		},
		spacing = settings.spacing,
		layout = wibox.layout.fixed.horizontal,
	})
end

function M.get_icon_color(level, low_level, medium_level, icons, colors)
	if level <= low_level then
		return ui_utils.markup_with_color(icons.low, colors.low)
	elseif level <= medium_level then
		return ui_utils.markup_with_color(icons.medium, colors.medium)
	else
		return ui_utils.markup_with_color(icons.high, colors.high)
	end
end

function M.get_icon(level, low_level, medium_level, icons)
	if level <= low_level then
		return icons.low
	elseif level <= medium_level then
		return icons.medium
	else
		return icons.high
	end
end

return M
