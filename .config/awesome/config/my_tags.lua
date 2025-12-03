local my_tags = { " ", "󰖟 ", "󰺷 ", " ", " " }

local M = {}

M.NUM_TAGS = #my_tags

---@param pos number
---@return string
M.get = function(pos)
	pos = pos or -1
	if pos < 1 or pos > M.NUM_TAGS then
		return my_tags[1]
	end

	return my_tags[pos]
end

---@return table
M.get_all = function()
	return my_tags
end

return M
