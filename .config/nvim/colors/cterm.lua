vim.cmd("highlight clear")
vim.cmd("syntax reset")

vim.g.colors_name = "windows-96"

local function hl(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

local colors = {
    black       = 0,  -- base00
    brightBlack = 8,  -- base01
    gray        = 7,  -- base05
    white       = 15, -- base07
    red         = 1,
    green       = 2,
    yellow      = 3,
    blue        = 4,
    magenta     = 5,
    cyan        = 6,
    bg          = 0,  -- black background
    fg          = 7,  -- light gray foreground
}

-- "#313244"
-- Basics
hl("Normal",       { ctermfg = colors.white, ctermbg = colors.black })
hl("NormalFloat",  { ctermfg = colors.fg, ctermbg = colors.black })
hl("CursorLine",   { ctermbg = colors.brightBlack })
hl("LineNr",       { ctermfg = colors.gray })
hl("CursorLineNr", { ctermfg = colors.yellow, bold = true })

hl("Visual",       { bg = "#45475a" })
hl("Search",       { ctermfg = colors.ctermbg, bg = colors.yellow })

hl("Comment",    { ctermfg = colors.gray, italic = true })
hl("String",     { ctermfg = colors.green })
hl("Number",     { ctermfg = colors.magenta })
hl("Boolean",    { ctermfg = colors.magenta })
hl("Function",   { ctermfg = colors.blue })
hl("Identifier", { ctermfg = colors.fg })
hl("Keyword",    { ctermfg = colors.red })
hl("Type",       { ctermfg = colors.yellow })

-- Diagnostics
hl("DiagnosticError", { ctermfg = colors.red })
hl("DiagnosticWarn",  { ctermfg = colors.yellow })
hl("DiagnosticInfo",  { ctermfg = colors.blue })
hl("DiagnosticHint",  { ctermfg = colors.cyan })

-- Underlines
hl("DiagnosticUnderlineError", { undercurl = true, sp = colors.red })
hl("DiagnosticUnderlineWarn",  { undercurl = true, sp = colors.yellow })
hl("DiagnosticUnderlineInfo",  { undercurl = true, sp = colors.blue })
hl("DiagnosticUnderlineHint",  { undercurl = true, sp = colors.cyan })

-- Variables
hl("@lsp.type.variable",  { ctermfg = colors.fg })
hl("@lsp.type.property",  { ctermfg = colors.white })
hl("@lsp.type.parameter", { ctermfg = colors.fg, italic = true })

-- Functions
hl("@lsp.type.function", { ctermfg = colors.blue })
hl("@lsp.type.method",   { ctermfg = colors.blue })

-- Types
hl("@lsp.type.class",     { ctermfg = colors.yellow })
hl("@lsp.type.struct",    { ctermfg = colors.yellow })
hl("@lsp.type.enum",      { ctermfg = colors.yellow })
hl("@lsp.type.interface", { ctermfg = colors.yellow })

-- Keywords
hl("@lsp.type.keyword", { ctermfg = colors.red })

hl("@comment",  { link = "Comment" })
hl("@string",   { link = "String" })
hl("@number",   { link = "Number" })
hl("@boolean",  { link = "Boolean" })
hl("@function", { link = "Function" })
hl("@type",     { link = "Type" })
hl("@keyword",  { link = "Keyword" })

hl("Pmenu",      { ctermfg = colors.fg, bg = "#313244" })
hl("PmenuSel",   { ctermfg = colors.ctermbg, bg = colors.blue })
hl("PmenuSbar",  { bg = "#45475a" })
hl("PmenuThumb", { ctermbg = colors.gray })

-- Doxygen documentation
hl("@comment.documentation", { italic = true })
hl("@tag", { bold = true })
