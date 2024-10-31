require "nvchad.mappings"

local map = vim.keymap.set

map({ "n", "v" }, ";", ":", { desc = "CMD enter command mode" })
map("n", "<F9>", ":noh<CR>", { desc = "Clear highlight", silent = true })
map("i", "<C-H>", "<C-W>", { desc = "Ctrl + Backspace delete previous word" })
map({ "v", "n" }, "H", "0")
map({ "v", "n" }, "L", "$")

-- Vim-tmux-navigator
map("n", "<C-k>", ":wincmd k<CR>", { silent = true })
map("n", "<C-j>", ":wincmd j<CR>", { silent = true })
map("n", "<C-h>", ":wincmd h<CR>", { silent = true })
map("n", "<C-l>", ":wincmd l<CR>", { silent = true })

-- Navigate wrap lines
map({ "n", "v" }, "j", "gj")
map({ "n", "v" }, "k", "gk")
map({ "n", "v" }, "<Down>", "gj")
map({ "n", "v" }, "<Up>", "gk")

-- Terminal
map("t", "<ESC>", "<C-\\><C-n>", { desc = "ESC quits terminal" })
