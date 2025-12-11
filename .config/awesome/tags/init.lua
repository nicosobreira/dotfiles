local settings = require("settings")

local M = {}

M.total = #settings.tags

---@param pos number
---@return string
M.get = function(pos)
	pos = pos or -1

	if pos < 1 or pos > M.total then
		return settings.tags[1]
	end

	return settings.tags[pos]
end

---@return table
M.get_all = function()
	return settings.tags
end

return M
