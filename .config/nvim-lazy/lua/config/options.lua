-- Config --
opt.clipboard = "unnamed"
opt.backup = false
opt.swapfile = false

o.termguicolors = true
cmd.colorscheme "slate"

opt.linebreak = true
opt.scrolloff = 5
opt.relativenumber = true

opt.hlsearch = true
opt.ignorecase = true

local tap_space = 4
opt.tabstop = tap_space
opt.shiftwidth = tap_space
opt.autoindent = true
opt.smarttab = true
opt.expandtab = false

vim.loader.enable()
