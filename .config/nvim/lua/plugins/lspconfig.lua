return {
	"neovim/nvim-lspconfig",
	config = function()
		require("nvchad.configs.lspconfig").defaults()

		local lspconfig = require("lspconfig")
		local nvlsp = require("nvchad.configs.lspconfig")
		nvlsp.defaults()

		local servers = {
			ts_ls = {},
			html = {},
			cssls = {},
			bashls = {},

			clangd = {
				settings = {
					clangd = {
						diagnostics = true,
					},
				},
			},
			pyright = {
				settings = {
					python = {
						analysis = {
							autoSearchPaths = true,
							typeCheckingMode = "basic",
						},
					},
				},
			},
		}

		-- lsps with default config
		for name, opts in pairs(servers) do
			opts.on_attach = nvlsp.on_attach
			opts.on_init = nvlsp.on_init
			opts.capabilities = nvlsp.capabilities
			lspconfig[name].setup(opts)
		end

		-- lspconfig.lua_ls.setup({
		-- 	on_attach = nvlsp.on_attach,
		-- 	on_init = nvlsp.on_init,
		-- 	capabilities = nvlsp.capabilities,
		-- 	settings = {
		-- 		Lua = {
		-- 			diagnostics = {
		-- 				disable = { "missing-parameter" },
		-- 				globals = { "vim" },
		-- 			},
		-- 			workspace = {
		-- 				library = {
		-- 					vim.fn.expand("$VIMRUNTIME/lua"),
		-- 					vim.fn.expand("$VIMRUNTIME/lua/vim/lsp"),
		-- 					vim.fn.stdpath("data") .. "/lazy/ui/nvchad_types",
		-- 					vim.fn.stdpath("data") .. "/lazy/lazy.nvim/lua/lazy",
		-- 					"${3rd}/luv/library",
		-- 				},
		-- 				maxPreload = 100000,
		-- 				preloadFileSize = 10000,
		-- 			},
		-- 		},
		-- 	},
		-- })
		lspconfig.pyright.setup({})
	end,
}
