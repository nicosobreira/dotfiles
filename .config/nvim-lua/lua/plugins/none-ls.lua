return {
	{
		"nvimtools/none-ls.nvim",
		config = function()
			local nls = require("null-ls")
			local formatting = nls.builtins.formatting
			local completion = nls.builtins.completion
			--
			local sources = {
				formatting.stylua,
				--	completion.spell,
			}
			nls.setup({ sources = sources })
			map("n", "<leader>gf", vim.lsp.buf.format)
		end,
	},
	{
		"jay-babu/mason-null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"nvimtools/none-ls.nvim",
		},
		config = function()
			require("mason-null-ls").setup({
				--auto_install = true,
				ensure_installed = { "stylua" },
			})
			require("null-ls") -- require your null-ls config here (example below)
		end,
	},
}
