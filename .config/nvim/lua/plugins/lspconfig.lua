return {
  "neovim/nvim-lspconfig",
  config = function()
    require("nvchad.configs.lspconfig").defaults()

    local lspconfig = require "lspconfig"
    local nvlsp = require "nvchad.configs.lspconfig"

    local servers = { "ts_ls", "html", "cssls", "pyright", "clangd" }

    -- lsps with default config
    for _, lsp in ipairs(servers) do
      lspconfig[lsp].setup {
        on_attach = nvlsp.on_attach,
        on_init = nvlsp.on_init,
        capabilities = nvlsp.capabilities,
        -- init_options = {
        --   preferences = {
        --     disableSuggestions = true,
        --   },
        -- },
      }
    end
    lspconfig.clangd.setup {
      -- Optional: Enable clangd-specific settings
      -- cmd = { "clangd", "--background-index", "--compile-commands-dir=build" },
      settings = {
        clangd = {
          -- Additional clangd settings
          diagnostics = true,
        },
      },
    }

    -- configuring single server, example: typescript
    lspconfig.pyright.setup {
      settings = {
        python = {
          analysis = {
            autoSearchPaths = true,
            typeCheckingMode = "basic",
          },
        },
      },
    }
  end,
}
