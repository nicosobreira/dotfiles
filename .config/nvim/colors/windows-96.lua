local function hl(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

--[[
name: "Windows 95"
author: "Fergus Collins (https://github.com/ferguscollins)"
variant: "dark"
--]]
local base16 = {
	base00 = "#000000", -- black
	base01 = "#1C1C1C", -- darkish black
	base02 = "#383838", -- brightish black
	base03 = "#545454", -- bright black
	base04 = "#7e7e7e", -- darker white
	base05 = "#a8a8a8", -- white
	base06 = "#d2d2d2", -- middle white
	base07 = "#fcfcfc", -- bright white
	base08 = "#fc5454", -- bright red
	base09 = "#a85400", -- yellow
	base0A = "#fcfc54", -- bright yellow
	base0B = "#54fc54", -- bright green
	base0C = "#54fcfc", -- bright cyan
	base0D = "#5454fc", -- bright blue
	base0E = "#fc54fc", -- bright magenta
	base0F = "#00a800", -- green
}

local colors = {
	bg       = base16.base00,
	fg       = base16.base05,
	red      = base16.base08,
	green    = base16.base0B,
	yellow   = base16.base0A,
	blue     = base16.base0D,
	magenta  = base16.base0E,
	cyan     = base16.base0C,
	gray     = base16.base04,
	brightBlack = base16.base02,
	middleWhite = base16.base06
}

-- "#313244"
-- Basics
hl("Normal",       { fg = colors.fg, bg = colors.bg })
hl("NormalFloat",  { fg = colors.fg, bg = colors.bg })
hl("CursorLine",   { bg = colors.brightBlack })
hl("LineNr",       { fg = colors.gray })
hl("CursorLineNr", { fg = colors.yellow, bold = true })

hl("Visual",       { bg = colors.middleWhite })
hl("Search",       { fg = colors.bg, bg = colors.yellow })

hl("Comment",    { fg = colors.gray, italic = true })
hl("String",     { fg = colors.green })
hl("Number",     { fg = colors.magenta })
hl("Boolean",    { fg = colors.magenta })
hl("Function",   { fg = colors.blue })
hl("Identifier", { fg = colors.fg })
hl("Keyword",    { fg = colors.red })
hl("Type",       { fg = colors.yellow })

-- Diagnostics
hl("DiagnosticError", { fg = colors.red })
hl("DiagnosticWarn",  { fg = colors.yellow })
hl("DiagnosticInfo",  { fg = colors.blue })
hl("DiagnosticHint",  { fg = colors.cyan })

-- Underlines
hl("DiagnosticUnderlineError", { undercurl = true, sp = colors.red })
hl("DiagnosticUnderlineWarn",  { undercurl = true, sp = colors.yellow })
hl("DiagnosticUnderlineInfo",  { undercurl = true, sp = colors.blue })
hl("DiagnosticUnderlineHint",  { undercurl = true, sp = colors.cyan })

-- Variables
hl("@lsp.type.variable",  { fg = colors.fg })
hl("@lsp.type.property",  { fg = colors.white })
hl("@lsp.type.parameter", { fg = colors.fg, italic = true })

-- Functions
hl("@lsp.type.function", { fg = colors.blue })
hl("@lsp.type.method",   { fg = colors.blue })

-- Types
hl("@lsp.type.class",     { fg = colors.yellow })
hl("@lsp.type.struct",    { fg = colors.yellow })
hl("@lsp.type.enum",      { fg = colors.yellow })
hl("@lsp.type.interface", { fg = colors.yellow })

-- Keywords
hl("@lsp.type.keyword", { fg = colors.red })

hl("@comment",  { link = "Comment" })
hl("@string",   { link = "String" })
hl("@number",   { link = "Number" })
hl("@boolean",  { link = "Boolean" })
hl("@function", { link = "Function" })
hl("@type",     { link = "Type" })
hl("@keyword",  { link = "Keyword" })

hl("Pmenu",      { fg = colors.fg, bg = colors.brightBlack })
hl("PmenuSel",   { fg = colors.bg, bg = colors.blue })
hl("PmenuSbar",  { bg = colors.middleWhite })
hl("PmenuThumb", { bg = colors.gray })

-- Documentation
hl("@comment", { link = "Comment" })
hl("@comment.documentation", { link = "Comment" })

hl("@comment.todo",    { fg = colors.fg })
hl("@comment.note",    { fg = colors.cyan })
hl("@comment.hint",    { fg = colors.blue })
hl("@comment.error",   { fg = colors.red })
hl("@comment.warning", { fg = colors.yellow })

hl("@tag", { bold = true })
