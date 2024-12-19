return {
  "nvim-tree/nvim-tree.lua",
  opts = {
    filters = { dotfiles = false },
  },
  keys = {
    { "<C-n>", "<cmd>NvimTreeToggle<CR>", desc = "Toggle nvim-tree" },
  },
}
