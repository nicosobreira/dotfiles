require "nvchad.options"

local opt = vim.opt
local autocmd = vim.api.nvim_create_autocmd

opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true

-- Options --
opt.relativenumber = true
opt.scrolloff = 5
opt.breakindent = true
opt.linebreak = true
opt.swapfile = false
opt.spell = true

-- Auto commands --
autocmd("TermOpen", {
  group = vim.api.nvim_create_augroup("custom-term-open", { clear = true }),
  callback = function()
    opt.number = false
    opt.relativenumber = false
    opt.spell = false
  end,
})
