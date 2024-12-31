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
		}
		servers.clangd = {
			on_attach = nvlsp.on_attach,
			on_init = nvlsp.on_init,
			capabilities = nvlsp.capabilities,
			settings = {
				clangd = {
					diagnostics = true,
				},
			},
		}
		servers.pyright = {
			on_attach = nvlsp.on_attach,
			on_init = nvlsp.on_init,
			capabilities = nvlsp.capabilities,
			settings = {
				python = {
					analysis = {
						autoSearchPaths = true,
						typeCheckingMode = "basic",
					},
				},
			},
		}

		-- lsps with default config
		for _, lsp in ipairs(servers) do
			lspconfig[lsp].setup({
				on_attach = nvlsp.on_attach,
				on_init = nvlsp.on_init,
				capabilities = nvlsp.capabilities,
			})
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
