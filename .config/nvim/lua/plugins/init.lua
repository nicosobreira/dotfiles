return {
  {
    dir = "~/code/lua/nvim-plugins/nvimrc",
    name = "nvimrc",
    -- dev = true,
    lazy = false,
    opts = {
      file_name = ".nvim",
    },
  },
  {
    "folke/which-key.nvim",
    lazy = false,
  },
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      require "configs.dap"
    end,
  },
  {
    "mxsdev/nvim-dap-vscode-js",
    ft = "javascript",
    dependencies = {
      "mfussenegger/nvim-dap",
    },
  },
  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    dependencies = {
      "mfussenegger/nvim-dap",
    },
    config = function()
      local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
      require("dap-python").setup(path)
      -- require("core.utils").load_mappings "dap_python"
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    enabled = false,
  },
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- uncomment for format on save
    opts = require "configs.conform",
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "js-debug-adapter",
        "debugpy",
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
        "javascript",
      },
    },
  },
  {
    "christoomey/vim-tmux-navigator",
    event = function()
      if vim.fn.exists "$TMUX" == 1 then
        return "VeryLazy"
      end
    end,
  },
}
