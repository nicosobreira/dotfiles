return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	---@module "conform"
	---@type conform.setupOpts
	opts = {
		formatters = {
			clang_format = {
				prepend_args = { "--fallback-style=Microsoft" },
			},
		},

		formatters_by_ft = {
			nix = { "alejandra" },
			lua = { "stylua" },
			c = { "clang_format" },
			cpp = { "clang_format" },
		},

		format_on_save = {
			timeout_ms = 2000,
			lsp_fallback = true,
		},
	},

	keys = {
		{
			"<leader>=",
			function()
				require("conform").format({ async = true })
			end,
			desc = "Format current buffer",
		},
	},
	init = function()
		-- If you want the formatexpr, here is the place to set it
		vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
	end,
}
