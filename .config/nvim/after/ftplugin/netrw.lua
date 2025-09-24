if vim.bo.filetype ~= "netrw" then
	return
end

-- Navigation mappings
vim.keymap.set("n", "h", "-", { buffer = true, remap = true, desc = "Up directory" })
vim.keymap.set("n", "l", "<CR>", { buffer = true, remap = true, desc = "Open directory/file" })

-- File operations
vim.keymap.set("n", "a", "%", { buffer = true, remap = true, desc = "Create file" })
vim.keymap.set("n", "r", "R", { buffer = true, remap = true, desc = "Rename file" })

-- Quit mapping
vim.keymap.set("n", "q", "<cmd>q<CR>", { buffer = true, remap = true, desc = "Close Netrw" })
