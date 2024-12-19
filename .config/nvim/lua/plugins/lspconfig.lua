return {
  "neovim/nvim-lspconfig",
  config = function()
    require("nvchad.configs.lspconfig").defaults()

    local lspconfig = require "lspconfig"
    local nvlsp = require "nvchad.configs.lspconfig"
    nvlsp.defaults()

    local servers = { "ts_ls", "html", "cssls", "pyright", "clangd", "bashls" }

    -- lsps with default config
    for _, lsp in ipairs(servers) do
      lspconfig[lsp].setup {
        on_attach = nvlsp.on_attach,
        on_init = nvlsp.on_init,
        capabilities = nvlsp.capabilities,
      }
    end

    lspconfig.clangd.setup {
      settings = {
        clangd = {
          diagnostics = true,
        },
      },
    }

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
