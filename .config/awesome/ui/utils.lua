local beautiful = require("beautiful")

local naughty = require("naughty")

local M = {}

function M.font_resize(new_size)
	-- Match everything up to the last number (the size)
	local font = beautiful.font or ""
	local family = font:match("%D+")

	if not family then
		-- If no size found, assume whole string is font family
		family = font
	end

	return family .. tostring(new_size)
end

function M.markup_with_color(text, color_fg)
	return string.format('<span foreground="%s">%s</span>', color_fg, text)
end

return M
