require("nvchad.options")

local opt = vim.opt
local autocmd = vim.api.nvim_create_autocmd

opt.softtabstop = 4
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = false

-- Options --
opt.relativenumber = true
opt.clipboard = "unnamed,unnamedplus"
opt.scrolloff = 5
opt.breakindent = true
opt.linebreak = true
opt.swapfile = false
opt.spell = true
opt.spelllang = { "en", "pt_br" }

-- Auto commands --
autocmd("TermOpen", {
	group = vim.api.nvim_create_augroup("custom-term-open", { clear = true }),
	callback = function()
		opt.number = false
		opt.relativenumber = false
		opt.spell = false
	end,
})

-- dofile(vim.fn.stdpath("config") .. "/lua/" .. "floating-terminal.lua")
