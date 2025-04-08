-- Key mappings
vim.g.mapleader = ' '

-- Save
vim.keymap.set('n', '<C-s>', '<cmd>w<CR>')

-- Swap colon and semicolon
vim.keymap.set({'n', 'v', 'o'}, ';', ':')
vim.keymap.set({'n', 'v', 'o'}, ':', ';')

-- Line navigation
vim.keymap.set('n', 'H', '_')
vim.keymap.set('n', 'L', '$')

-- Terminal mappings
vim.keymap.set('t', '<ESC>', '<C-\\><C-n>')
local term_maps = {
	{'<C-h>', '<C-\\><C-n><cmd>wincmd h<CR>'},
	{'<C-j>', '<C-\\><C-n><cmd>wincmd j<CR>'},
	{'<C-k>', '<C-\\><C-n><cmd>wincmd k<CR>'},
	{'<C-l>', '<C-\\><C-n><cmd>wincmd l<CR>'},
}
for _, map in ipairs(term_maps) do
	vim.keymap.set('t', map[1], map[2])
end

-- Netrw mappings
vim.api.nvim_create_autocmd('FileType', {
	pattern = 'netrw',
	callback = function()
		vim.keymap.set('n', 'h', '-', { buffer = true })
		vim.keymap.set('n', 'l', '<CR>', { buffer = true })
	end
})
vim.keymap.set('n', '<leader>e', '<cmd>Lexplore<CR>')

-- Window navigation
local win_maps = {
	{'<C-h>', '<C-w>h'},
	{'<C-j>', '<C-w>j'},
	{'<C-k>', '<C-w>k'},
	{'<C-l>', '<C-w>l'},
}
for _, map in ipairs(win_maps) do
	vim.keymap.set('n', map[1], map[2])
end

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
vim.keymap.set('n', '<leader>s', function()
	vim.opt.spell = not vim.opt.spell:get()
	print('Spell check ' .. (vim.opt.spell:get() and 'ON' or 'OFF'))
end)
vim.keymap.set('n', '<leader>=', function()
	-- Save current cursor position
	local save_pos = vim.api.nvim_win_get_cursor(0)

	vim.cmd('undojoin')

	vim.cmd('normal! gg=G')
	
	-- Return cursor position
	vim.api.nvim_win_set_cursor(0, save_pos)
end,
{ desc = 'Format file and return to position' })
vim.keymap.set('x', '<', '<gv')
vim.keymap.set('x', '>', '>gv')
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz') 
