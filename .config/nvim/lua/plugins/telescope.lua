return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	-- tag = "0.1.8",
	dependencies = {
		{ 'nvim-lua/plenary.nvim' },
		{
			'nvim-telescope/telescope-fzf-native.nvim',
			-- If `make` isn't installed don't load
			cond = function()
				return vim.fn.executable 'make' == 1
			end,
			build = 'make'
		}
	},
	cmd = { "Telescope" },
	opts = {
		defaults = {
			file_ignore_patterns = {
				"^.git/",
				"%.o"
			}
		}
	},
	keys = {
		{
			"<leader>ff",
			function()
				require("telescope.builtin").find_files()
			end,
			desc = "[f]ind [f]iles"
		},
		{
			"<space>fa",
			function()
				require("telescope.builtin").find_files({ follow = true, no_ignore = true, hidden = true })
			end,
			desc = "[f]ind [a]ll files",
		},
		{
			"<leader>fw",
			function()
				require("telescope.builtin").live_grep()
			end,
			desc = "[f]ind [w]ords"
		},
		{
			"<leader>fh",
			function()
				require("telescope.builtin").help_tags()
			end,
			desc = "[f]ind [h]elp pages"
		}
	}
}
