return {
	enabled = false,
	"nvimtools/none-ls.nvim",
	dependencies = {"nvim-lua/plenary.nvim"},
	ft = {"bash", "sh"},
	config = function()
		local null_ls = require("null-ls");
		null_ls.setup({
			sources = {
				null_ls.builtins.diagnostics.shellcheck,
			},
		})
	end,
}
