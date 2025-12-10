return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	opts = {
		formatters_by_ft = {
			nix = { "alejandra" },
			lua = { "stylua" },
		},

		format_on_save = {
			timeout_ms = 2000,
			lsp_fallback = true,
		},
	},

	config = function(_, opts)
		require("conform").setup(opts)

		for _, formatterList in pairs(opts.formatters_by_ft) do
			for _, formatter in ipairs(formatterList) do
				require("conform").formatters[formatter] = {
					command = formatter,
					args = { "-" },
					stdin = true,
				}
			end
		end
	end,
}
