local map = vim.keymap.set

-- Basics
map({ "n", "v" }, ";", ":", { desc = "CMD enter command mode" })
map("n", "<Esc>", "<cmd>noh<CR>", { desc = "Clear highlight" })
map("i", "<C-H>", "<C-W>", { desc = "Ctrl + Backspace delete previous word" })
map({ "v", "n" }, "H", "0")
map({ "v", "n" }, "L", "$")
map("n", "<C-s>", "<cmd>w<CR>", { desc = "Save current file" })

-- Vim-tmux-navigator
map({ "n", "t" }, "<C-k>", "<cmd>wincmd k<CR>", { desc = "Move to window up" })
map({ "n", "t" }, "<C-j>", "<cmd>wincmd j<CR>", { desc = "Move to window down" })
map({ "n", "t" }, "<C-h>", "<cmd>wincmd h<CR>", { desc = "Move to window left" })
map({ "n", "t" }, "<C-l>", "<cmd>wincmd l<CR>", { desc = "Move to window right" })

-- Navigate in wrap lines
map({ "n", "v" }, "j", "gj")
map({ "n", "v" }, "k", "gk")
map({ "n", "v" }, "<Down>", "gj")
map({ "n", "v" }, "<Up>", "gk")

-- Terminal
map("t", "<ESC>", "<C-\\><C-n>", { desc = "ESC enter normal mode" })

-- Tab management
map("n", "<Tab>", "gt", { desc = "Go to next tab" })
map("n", "<S-Tab>", "gT", { desc = "Go to previous tab" })
map("n", "<space>n", "<cmd>$tabnew<CR>", { desc = "Create a tab after last one" })
map("n", "<space>N", "<cmd>0tabnew<CR>", { desc = "Create a tab before first one" })
map("n", "<space>x", "<cmd>tabclose<CR>", { desc = "Close current tab" })

-- LSP
map("n", "<space>d", function()
	vim.diagnostic.open_float()
end, { desc = "Unfold diagnostic" })

vim.api.nvim_create_user_command("Diagnostics", function()
	vim.diagnostic.setqflist()
end, {})
