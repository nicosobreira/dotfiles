local beautiful = require("beautiful")

local naughty = require("naughty")

local M = {}

-- FIX: Font_resize function doesn't work. beautiful.font don't exist
function M.font_resize(new_size)
	-- Match everything up to the last number (the size)
	local font = beautiful.font or ""
	local family = font:match("%D+")

	naughty.notify({
		preset = naughty.config.presets.critical,
		title = "debug",
		text = beautiful.font,
		position = "bottom_right",
	})

	if not family then
		-- If no size found, assume whole string is font family
		family = font
	end

	return family .. " " .. tostring(new_size)
end

return M
