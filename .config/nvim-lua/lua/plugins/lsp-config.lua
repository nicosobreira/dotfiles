return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		opts = {
			auto_install = true
		},
		--[[
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "bashls", "clangd", "cmake" },
				automatic_installation = true,
			})
		end, --]]
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local lspconfig = require("lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			map("n", "<leader>ca", vim.lsp.buf.code_action)
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
			})
			--lspconf.clangd.setup({})
			--lspconf.cmake.setup({})
		end,
	},
}
