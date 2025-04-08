local M = {}

function M.get()
	local tab_count = vim.fn.tabpagenr('$')

	-- Return empty string if only one tab exists
	if tab_count <= 1 then
		-- vim.opt.showtabline = 0
		return ''
	end

	local tabline = ''
	local current_tab = vim.fn.tabpagenr()

	for i = 1, tab_count do
		if i == current_tab then
			tabline = tabline .. '%#TabLineSel#' -- Highlight current tab
		else
			tabline = tabline .. '%#TabLine#'    -- Normal highlight for others
		end

		tabline = tabline .. '[' .. i .. ']'

		-- Add separator between tabs (except after last one)
		if i < tab_count then
			tabline = tabline .. ' '
		end
	end

	return tabline
end

return M
