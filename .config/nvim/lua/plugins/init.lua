return {
  {
    "hrsh7th/nvim-cmp",
    enabled = false
  },
  {
    "stevearc/conform.nvim",
    event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
  {
  	"nvim-treesitter/nvim-treesitter",
  	opts = {
  		ensure_installed = {
  			"vim", "lua", "vimdoc",
       "html", "css"
      },
  	},
  },
  {
  "christoomey/vim-tmux-navigator",
  event = function()
    if vim.fn.exists("$TMUX") == 1 then
      return "VeryLazy"
    end
  end,
  }
}
