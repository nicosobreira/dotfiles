-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "chadracula-evondev",

  hl_override = {
    Comment = { italic = true },
    ["@comment"] = { italic = true },
  },
}

-- M.mason.pkgs = {
--   "clangd",
--   "codelldb",
--   "css-lsp",
--   "debugpy",
--   "html-lsp",
--   "js-debug-adapter",
--   "lua-language-server",
--   "pyright",
--   "stylua",
--   "typescript-language-server",
--   "bash-language-server",
-- }

M.ui = {
  tabufline = {
    order = { "treeOffset", "tabs" },
  },
}

return M
