return {
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.icons" }, -- if you use standalone mini plugins
		---@module 'render-markdown'
		---@type render.md.UserConfig
		opts = {
			heading = {
				icons = { "" },
			},
		},
	},
	{
		"jubnzv/mdeval.nvim",
		ft = { "markdown" },
		opts = {
			require_confirmation = false,
		},
		config = function(_, opts)
			require("mdeval").setup(opts)
		end,

		keys = {
			{
				"<leader>c",
				function()
					require("mdeval").eval_code_block()
				end,
				desc = "evaluate a code block",
			},
		},
	},
}
