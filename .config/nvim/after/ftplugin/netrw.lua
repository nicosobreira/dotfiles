if vim.bo.filetype ~= 'netrw' then
	return
end

-- Navigation mappings
vim.keymap.set('n', 'h', '-', { buffer = true, remap = true, desc = 'Up directory' })
vim.keymap.set('n', 'l', '<CR>', { buffer = true, remap = true, desc = 'Open directory/file' })

-- File operations
vim.keymap.set('n', 'a', '%', { buffer = true, remap = true, desc = 'Create file' })
vim.keymap.set('n', 'd', 'D', { buffer = true, remap = true, desc = 'Delete file' })
vim.keymap.set('n', 'r', 'R', { buffer = true, remap = true, desc = 'Rename file' })

-- Quit mapping
vim.keymap.set('n', 'q', ':q<CR>', { buffer = true, desc = 'Close Netrw' })

-- Netrw settings
vim.g.netrw_banner = 0			-- Disable banner
vim.g.netrw_liststyle = 3		-- Tree style listing
vim.wo.cursorline = true		-- Highlight current line
vim.wo.number = false			-- Disable line numbers
vim.wo.relativenumber = false	-- Disable relative numbers
