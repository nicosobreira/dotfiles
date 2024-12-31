return {
	lazy = false,
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release",
		},
	},
	keys = {
		{
			"<space>ff",
			function()
				require("telescope.builtin").find_files()
			end,
			desc = "Telescope find files",
		},
		{
			"<space>fw",
			function()
				require("telescope.builtin").live_grep()
			end,
			desc = "Telescope live grep",
		},
		{
			"<space>fb",
			function()
				require("telescope.builtin").buffers()
			end,
			desc = "Telescope find buffers",
		},
		{
			"<space>fh",
			function()
				require("telescope.builtin").help_tags()
			end,
			desc = "Telescope help page",
		},
		{
			"<space>ma",
			function()
				require("telescope.builtin").marks()
			end,
			desc = "Telescope find marks",
		},
		{
			"<space>fo",
			function()
				require("telescope.builtin").oldfiles()
			end,
			desc = "Telescope find oldfiles",
		},
		{
			"<space>fz",
			function()
				require("telescope.builtin").current_buffer_fuzzy_find()
			end,
			desc = "Telescope find in current buffer",
		},
		{
			"<space>cm",
			function()
				require("telescope.builtin").git_commits()
			end,
			desc = "Telescope git commits",
		},
		{
			"<space>gt",
			function()
				require("telescope.builtin").git_status()
			end,
			desc = "Telescope git status",
		},
		{
			"<space>pt",
			function()
				require("telescope.builtin").terms()
			end,
			desc = "Telescope pick hidden term",
		},
		{
			"<space>fa",
			function()
				require("telescope.builtin").find_files({ follow = true, no_ignore = true, hidden = true })
			end,
			desc = "Telescope find all files",
		},

		{
			"<space>th",
			function()
				require("nvchad.themes").open()
			end,
			desc = "Telescope nvchad themes",
		},
		{
			"<space>en",
			function()
				require("telescope.builtin").find_files({
					cwd = vim.fn.stdpath("config"),
				})
			end,
			desc = "Telescope nvim config",
		},
		{
			"<space>ed",
			function()
				require("telescope.builtin").find_files({
					cwd = "~/dotfiles",
					follow = true,
					no_ignore = true,
					hidden = true,
				})
			end,
			desc = "Telescope dotfiles",
		},
	},
}
