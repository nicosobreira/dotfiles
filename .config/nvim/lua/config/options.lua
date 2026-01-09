-- Initialize with default options
vim.opt.background = "dark"
vim.opt.termguicolors = true
vim.cmd("filetype plugin indent on")
vim.cmd("syntax enable")

-- Basic settings
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.mouse = "a"
vim.opt.autoread = true
vim.opt.encoding = "utf-8"
vim.opt.showmode = false
vim.opt.scrolloff = 10
vim.opt.backspace = { "indent", "eol", "start" }

-- Undo
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
vim.opt.undolevels = 10000

-- "Ominfunc" help size
vim.opt.pumheight = 10

-- Conceal (hide) `*` and `**`
vim.opt.conceallevel = 2

-- Spell check
vim.opt.spelllang = { "en", "pt_br" }

-- Indentation
vim.opt.breakindent = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smartindent = true
vim.opt.expandtab = false

-- Visual whitespace
vim.opt.list = true
vim.opt.listchars = { tab = "  ", trail = "*" }
-- vim.opt.listchars = { tab = "| ", trail = "*" }

-- Clipboard
vim.opt.clipboard:append("unnamedplus")

-- Auto comment
vim.opt.formatoptions = "croqnl"

-- Status line
vim.opt.laststatus = 2
vim.opt.confirm = true
vim.opt.title = true

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
vim.opt.wildmode = "longest:full,full"
vim.opt.wildoptions = "fuzzy"

-- Cursor shape
vim.o.guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20"

-- Folding
vim.opt.foldlevel = 99
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

-- Custom Tabline
vim.opt.tabline = "%!v:lua.require('custom.tabline').get()"
