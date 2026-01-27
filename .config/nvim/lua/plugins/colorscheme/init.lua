return {
	"y3owk1n/base16-pro-max.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		local colors = require("plugins.colorscheme.windows-96")

		require("base16-pro-max").setup({
			colors = colors,
			styles = {
				italic = true,
				bold = true,
				transparency = true,
			},
			plugins = {
				enable_all = true,
			},
			highlight_groups = {
				["StatusLine"] = {
					fg = colors.base01,
					bg = colors.base05,
				},

				["StatusLineNC"] = {
					fg = colors.base03,
					bg = colors.base01,
				},

				["TabLineFill"] = {
					fg = colors.base00,
					bg = colors.base00,
				},

				["@attribute"] = {
					fg = colors.base0E,
				},

				["@markup.heading"] = {
					fg = colors.base06,
					bg = colors.base00,
				},
				["@markup.heading.1"] = {
					fg = colors.base08,
					bg = colors.base00,
				},
				["@markup.heading.2"] = {
					fg = colors.base09,
					bg = colors.base00,
				},
				["@markup.heading.3"] = {
					fg = colors.base0B,
					bg = colors.base00,
				},
				["@markup.heading.4"] = {
					fg = colors.base0D,
					bg = colors.base00,
				},
				["@markup.heading.5"] = {
					fg = colors.base0E,
					bg = colors.base00,
				},
			},
		})

		vim.cmd.colorscheme("base16-pro-max")
	end,
}
