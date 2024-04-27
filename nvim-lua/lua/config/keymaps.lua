	-- Keymaps --
g.mapleader = ' '

map('', ';', ':')

-- map('', 'q', ':q!<cr>', {noremap = false})
map('', '<C-s>', ':w<cr>', {noremap = false})
map('n', '<leader>h', ':split ')
map('n', '<leader>v', '>vsplit ')

map('n', '<C-h>', '<C-w>h')
map('n', '<C-j>', '<C-w>j')
map('n', '<C-k>', '<C-w>k')
map('n', '<C-l>', '<C-w>l')

map('n', 'H', '^')
map('n', 'L', '$')
map('n', 'j', 'gj')
map('n', 'k', 'gk')

map('n', '<F9>', ':nohl<cr>')

command('Cd', ':cd %:h')
