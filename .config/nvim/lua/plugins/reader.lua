return {
	dir = "~/.config/nvim/plugins/reader.nvim", -- wherever you put it
	name = "reader.nvim", -- optional but avoids ambiguity
	cmd = { "ReaderOpen", "ReaderClose", "ReaderToggle" },
	keys = {
		{
			"<leader>ro",
			function()
				require("reader").toggle()
			end,
			desc = "Reader: toggle",
		},
	},
}
