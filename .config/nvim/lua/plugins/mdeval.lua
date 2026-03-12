return {
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
}
