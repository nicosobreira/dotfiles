return {
	"y3owk1n/base16-pro-max.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		local yaml_parser = require("base16-pro-max.parser")

		local theme = "windows-95"
		local path = vim.fn.expand("~") .. "/.config/nvim/lua/plugins/colorscheme/" .. theme .. ".yaml"

		-- Basic usage: load colors from a YAML file
		local colors = yaml_parser.get_base16_colors(path) -- or `yml` extension

		require("base16-pro-max").setup({
			colors = colors,
			highlight_groups = {
				["@markup.strong"] = {
					bold = true,
				},
				["@markup.italic"] = {
					italic = true
				},

				["@markup.heading"] = {
					fg = colors.base06,
					bg = colors.base00
				},
				["@markup.heading.1"] = {
					fg = colors.base08,
					bg = colors.base00
				},
				["@markup.heading.2"] = {
					fg = colors.base09,
					bg = colors.base00
				},
				["@markup.heading.3"] = {
					fg = colors.base0B,
					bg = colors.base00
				},
				["@markup.heading.4"] = {
					fg = colors.base0D,
					bg = colors.base00
				},
				["@markup.heading.5"] = {
					fg = colors.base0E,
					bg = colors.base00
				},
			}
		})

		vim.cmd.colorscheme("base16-pro-max")
  end,
}
