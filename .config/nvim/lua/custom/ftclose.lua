local M = {}

function M.setup()
	vim.keymap.set("n", "q", "<cmd>bd<cr>", {
		buffer = true,
		silent = true,
	})
end

return M
