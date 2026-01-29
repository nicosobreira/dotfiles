local M = {}

--- Dim a hex color by a percentage
---@param color string in hex format
---@param percent number from 0 to 100
---@return string nil new dimmed color or nil
function M.dim(color, percent)
	-- Remove the '#' if present
	color = color:gsub("#", "")

	-- Convert hex to decimal
	local r = tonumber(color:sub(1, 2), 16)
	local g = tonumber(color:sub(3, 4), 16)
	local b = tonumber(color:sub(5, 6), 16)

	-- Apply dimming
	local factor = (100 - percent) / 100
	r = math.floor(r * factor)
	g = math.floor(g * factor)
	b = math.floor(b * factor)

	-- Clamp values between 0 and 255
	r = math.max(0, math.min(255, r))
	g = math.max(0, math.min(255, g))
	b = math.max(0, math.min(255, b))

	-- Convert back to hex
	return string.format("#%02X%02X%02X", r, g, b)
end

return M
