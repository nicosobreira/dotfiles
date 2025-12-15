local beautiful = require("beautiful")

local M = {}

function M.font_get_size()
	local font = beautiful.font or "sans 10"
	local size = font:match("%d+") or 10

	return tonumber(size)
end

function M.font_resize(new_size)
	local font = beautiful.font or "sans 10"
	local family = font:match("%D+") or "sans "

	if not family then
		family = font
	end

	return family .. tostring(new_size)
end

function M.markup_with_color(text, color_fg)
	return string.format('<span foreground="%s">%s</span>', color_fg, text)
end

return M
