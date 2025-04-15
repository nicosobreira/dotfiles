-- Initialize with default options
vim.opt.background = 'dark'
vim.opt.termguicolors = true
vim.cmd("filetype plugin indent on")
vim.cmd("syntax enable")

-- Basic settings
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.mouse = 'a'
vim.opt.autoread = true
vim.opt.undofile = true
vim.opt.undolevels = 10000
vim.opt.encoding = 'utf-8'
vim.opt.showmode = false
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.scrolloff = 10

-- "Ominfunc" help size
vim.opt.pumheight = 10

-- Conceal (hide) `*` and `**`
vim.opt.conceallevel = 2

-- Spell check
vim.opt.spelllang = 'en,pt_br'

-- Indentation
vim.opt.breakindent = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.autoindent = true
vim.opt.smartindent = true

-- Visual whitespace
vim.opt.list = true
vim.opt.listchars = { tab = '| ', trail = '*' }

-- Clipboard
vim.opt.clipboard = 'unnamedplus'

-- Auto comment
vim.opt.formatoptions = 'cro'

-- Status line
vim.opt.laststatus = 2
vim.opt.confirm = true
vim.opt.title = true

-- Custom Tabline
vim.opt.tabline = "%!v:lua.require('custom.tabline').get()"

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true

-- Search
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Splits
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Wildmenu
vim.opt.wildmenu = true
vim.opt.wildmode = 'longest:full,full'
vim.opt.wildoptions = 'fuzzy'

-- Netrw settings
vim.g.netrw_list_hide = '^\\./$,^\\.\\./$'
vim.g.netrw_browse_split = 0
vim.g.netrw_hide = 1
vim.g.netrw_banner = 0
vim.g.netrw_altfile = 1
vim.g.netrw_alto = 1

-- Cursor shape
vim.o.guicursor = 'n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20'

-- Folding
vim.opt.foldmethod = "syntax"
vim.opt.foldlevel = 99
