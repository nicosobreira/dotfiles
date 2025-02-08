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
				filetype = { "python" },
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
	end,
}
