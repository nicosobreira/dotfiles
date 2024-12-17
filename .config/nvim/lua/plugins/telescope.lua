return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "BurntSushi/ripgrep",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
  keys = {
    { "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Telescope find files" },
    { "<leader>fw", "<cmd>Telescope live_grep<CR>", desc = "Telescope live grep" },
    { "<leader>fb", "<cmd>Telescope buffers<CR>", desc = "Telescope find buffers" },
    { "<leader>fh", "<cmd>Telescope help_tags<CR>", desc = "Telescope help page" },
    { "<leader>ma", "<cmd>Telescope marks<CR>", desc = "Telescope find marks" },
    { "<leader>fo", "<cmd>Telescope oldfiles<CR>", desc = "Telescope find oldfiles" },
    {
      "<leader>fz",
      "<cmd>Telescope current_buffer_fuzzy_find<CR>",
      desc = "Telescope find in current buffer",
    },
    { "<leader>cm", "<cmd>Telescope git_commits<CR>", desc = "Telescope git commits" },
    { "<leader>gt", "<cmd>Telescope git_status<CR>", desc = "Telescope git status" },
    { "<leader>pt", "<cmd>Telescope terms<CR>", desc = "Telescope pick hidden term" },
    {
      "<leader>fa",
      "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>",
      desc = "Telescope find all files",
    },
    {
      "<leader>th",
      function()
        require("nvchad.themes").open()
      end,
      desc = "Telescope nvchad themes",
    },
    {
      "<leader>en",
      function()
        require("telescope.builtin").find_files {
          cwd = vim.fn.stdpath "config",
        }
      end,
      desc = "Telescope open nvim config",
    },
  },
}
