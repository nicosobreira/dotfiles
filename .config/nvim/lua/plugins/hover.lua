return {
	"lewis6991/hover.nvim",
	keys = {
		{
			"K",
			function()
				require("hover").open()
			end,
			desc = "Better hover",
		},
	},
}
