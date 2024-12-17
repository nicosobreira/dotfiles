local map = vim.keymap.set

-- Basics
map({ "n", "v" }, ";", ":", { desc = "CMD enter command mode" })
map("n", "<Esc>", "<cmd>noh<CR>", { desc = "Clear highlight" })
map("i", "<C-H>", "<C-W>", { desc = "Ctrl + Backspace delete previous word" })
map({ "v", "n" }, "H", "0")
map({ "v", "n" }, "L", "$")
map("n", "<C-s>", "<cmd>w<CR>", { desc = "Save current file" })

-- Vim-tmux-navigator
map("n", "<C-k>", "<cmd>wincmd k<CR>", { desc = "Move to window up" })
map("n", "<C-j>", "<cmd>wincmd j<CR>", { desc = "Move to window down" })
map("n", "<C-h>", "<cmd>wincmd h<CR>", { desc = "Move to window left" })
map("n", "<C-l>", "<cmd>wincmd l<CR>", { desc = "Move to window right" })

-- Navigate in wrap lines
map({ "n", "v" }, "j", "gj")
map({ "n", "v" }, "k", "gk")
map({ "n", "v", "i" }, "<Down>", "<ESC>gji")
map({ "n", "v", "i" }, "<Up>", "<ESC>gki")

-- Terminal
vim.api.nvim_create_autocmd("TermOpen", {
  group = vim.api.nvim_create_augroup("custom-term-open", { clear = true }),
  callback = function()
    vim.opt.number = false
    vim.opt.relativenumber = false
  end,
})
map("t", "<ESC>", "<C-\\><C-n>", { desc = "ESC enter normal mode" })

-- Tab management
map("n", "<Tab>", "gt", { desc = "Go to next tab" })
map("n", "<S-Tab>", "gT", { desc = "Go to previous tab" })
map("n", "<leader>n", "<cmd>$tabnew<CR>", { desc = "Create a tab after last one" })
map("n", "<leader>N", "<cmd>0tabnew<CR>", { desc = "Create a tab before first one" })
map("n", "<leader>x", "<cmd>tabclose<CR>", { desc = "Close current tab" })

-- LSP
map("n", "<leader>d", function()
  vim.diagnostic.open_float()
end, { desc = "Unfold diagnostic" })
