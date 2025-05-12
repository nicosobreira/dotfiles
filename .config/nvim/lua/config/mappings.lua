-- Key mappings
vim.g.mapleader = ' '

-- Save
vim.keymap.set({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<CR><esc>", { desc = "Save File" })

-- Map <leader>1 ... 9 to switch to corresponding tabs
for i = 1, 9 do
	vim.keymap.set('n', '<leader>' .. i, '<cmd>tabn ' .. i .. '<CR>', { desc = 'Go to tab '.. i })
end

-- Swap colon and semicolon
vim.keymap.set({'n', 'v', 'o'}, ';', ':')
vim.keymap.set({'n', 'v', 'o'}, ':', ';')

-- Line navigation
vim.keymap.set({'n', 'v'}, 'H', '_')
vim.keymap.set({'n', 'v'}, 'L', '$')

-- Terminal mappings
vim.keymap.set('t', '<ESC><ESC>', '<C-\\><C-n>')
vim.keymap.set('t', '<C-h>', '<C-\\><C-n><cmd>wincmd h<CR>')
vim.keymap.set('t', '<C-j>', '<C-\\><C-n><cmd>wincmd j<CR>')
vim.keymap.set('t', '<C-k>', '<C-\\><C-n><cmd>wincmd k<CR>')
vim.keymap.set('t', '<C-l>', '<C-\\><C-n><cmd>wincmd l<CR>')

vim.keymap.set('n', '<leader>e', '<cmd>Explore<CR>')

-- Window navigation
vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-l>', '<C-w>l')

-- Visual line navigation
vim.keymap.set({'n', 'v'}, 'j', 'gj')
vim.keymap.set({'n', 'v'}, 'k', 'gk')

-- Tab navigation
vim.keymap.set('n', '<Tab>', 'gt')
vim.keymap.set('n', '<S-Tab>', 'gT')
vim.keymap.set('n', '<leader>n', '<cmd>$tabnew<CR>')
vim.keymap.set('n', '<leader>N', '<cmd>0tabnew<CR>')

-- Window resizing
local resize_maps = {
	{'<C-Up>', ':resize +2<CR>'},
	{'<C-Down>', ':resize -2<CR>'},
	{'<C-Left>', ':vertical resize +2<CR>'},
	{'<C-Right>', ':vertical resize -2<CR>'},
}
for _, map in ipairs(resize_maps) do
	vim.keymap.set('n', map[1], map[2], { silent = true })
end

-- Line moving
local move_maps = {
	{'<A-j>', ':m .+1<CR>=='},
	{'<A-k>', ':m .-2<CR>=='},
}
for _, map in ipairs(move_maps) do
	vim.keymap.set('n', map[1], map[2], { silent = true })
	vim.keymap.set('i', map[1], '<Esc>' .. map[2] .. 'gi', { silent = true })
	vim.keymap.set('v', map[1], ":m '>+1<CR>gv=gv", { silent = true })
end
vim.keymap.set('v', '<A-k>', ":m '<-2<CR>gv=gv", { silent = true })

-- Miscellaneous
vim.keymap.set('n', '<ESC>', '<cmd>nohl<CR>')
vim.keymap.set('n', 'Q', '<cmd>echo "Vi mode disable"<CR>')

-- Toggle spell check
vim.keymap.set('n', '<leader>s', function()
	vim.opt.spell = not vim.opt.spell:get()
	print('Spell check is ' .. (vim.opt.spell:get() and 'on' or 'off'))
end)

vim.keymap.set('n', '<leader>=', function()
	-- Save current cursor position
	local save_pos = vim.api.nvim_win_get_cursor(0)

	vim.cmd('undojoin')

	vim.cmd('normal! gg=G')

	-- Return cursor position
	vim.api.nvim_win_set_cursor(0, save_pos)
end,
	{ desc = 'Format file and return to position' }
)

vim.keymap.set('x', '<', '<gv')
vim.keymap.set('x', '>', '>gv')

-- Prettier moves
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

vim.keymap.set('n', 'G', 'Gzz')

-- Lazy
vim.keymap.set("n", "<leader>ll", "<cmd>Lazy<CR>")

-- Autocomplete in normal mode
vim.keymap.set("i", "<C-n>", "<C-x><C-o><C-n>", { noremap = false, silent = true})
vim.keymap.set("i", "<C-p>", "<C-x><C-o><C-p>", { noremap = false, silent = true})
