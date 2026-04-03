return {
	"mikavilpas/yazi.nvim",
	event = "VeryLazy",

	cond = function()
		return vim.fn.executable("yazi") == 1
	end,

	init = function()
		-- mark netrw as loaded so it's not loaded at all.
		vim.g.loaded_netrwPlugin = 1
	end,

	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	opts = {
		open_for_directories = true,
		keymaps = {
			show_help = "<f1>",
		},
	},
	keys = {
		{
			"<leader>e",
			"<cmd>Yazi<cr>",
			desc = "Open yazi file manager",
			remap = true,
		},
	},
}
