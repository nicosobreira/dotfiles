return {
  "stevearc/conform.nvim",
  event = "BufWritePre", -- uncomment for format on save
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      -- css = { "prettier" },
      -- html = { "prettier" },
    },
    format_on_save = {
      -- These options will be passed to conform.format()
      lsp_fallback = true,
    },
  },
}
