local SERVERS = {
	lua_ls = {
		settings = {
			Lua = {
				runtime = { version = "LuaJIT" },
				diagnostics = {
					globals = { "vim" }, -- Recognize `vim` global
				},
				workspace = {
					checkThirdParty = false,
					library = {
						vim.env.VIMRUNTIME,
						"${3rd}/luv/library",
					},
				},
				telemetry = { enable = false },
			},
		},
	},

	clangd = {
		settings = {
			cmd = {
				"clangd",
				"--background-index",
				"--clang-tidy",
				"--completion-style=detailed",
				"--header-insertion=iwyu",
				"--cross-file-rename",
				"--compile-commands-dir=build",
			},
		},
	},

	pyright = {
		settings = {
			python = {
				analysis = {
					typeCheckingMode = "basic", -- or "strict"
					autoSearchPaths = true,
					useLibraryCodeForTypes = true,
				},
			},
		},
	},

	cmake = {}
}

-- In NixOS, the lsp are download by the user
IS_NIXOS = vim.uv.fs_stat("/etc/NIXOS")

return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{
			"williamboman/mason.nvim",
			enabled = function()
				return not IS_NIXOS
			end,
		},
		{
			"williamboman/mason-lspconfig.nvim",
			enabled = function()
				return not IS_NIXOS
			end,
		},
	},

	config = function()
		if not IS_NIXOS then
			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = vim.tbl_keys(SERVERS),
			})
		end

		local capabilities = {}

		for name, config in pairs(SERVERS) do
			config.capabilities = capabilities

			config.on_attach = function(_, bufnr)
				local opts = { buffer = bufnr }

				vim.keymap.set("n", "<leader>d", vim.diagnostic.setqflist, opts)
				vim.keymap.set("n", "grd", vim.lsp.buf.definition, opts)
				vim.keymap.set("n", "grD", vim.lsp.buf.declaration, opts)
				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
				vim.keymap.set("n", "gri", vim.lsp.buf.implementation, opts)
				vim.keymap.set("n", "grn", vim.lsp.buf.rename, opts)
			end

			if config or next(config) ~= nil then
				vim.lsp.config(name, config)
			end

			vim.lsp.enable(name)
		end
	end,
}
