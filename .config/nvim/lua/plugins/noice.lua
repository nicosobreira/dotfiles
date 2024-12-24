return {
	"folke/noice.nvim",
	lazy = false,
	dependencies = { "MunifTanjim/nui.nvim" },
	enabled = false,
	config = function()
		require("noice").setup({
			lsp = {
				signature = {
					enabled = false,
				},
				hover = {
					enabled = false,
				},
			},
			presets = {
				bottom_search = true, -- use a classic bottom cmdline for search
				command_palette = true, -- position the cmdline and popupmenu together
				long_message_to_split = true, -- long messages will be sent to a split
				inc_rename = false, -- enables an input dialog for inc-rename.nvim
			},
		})
	end,
}
