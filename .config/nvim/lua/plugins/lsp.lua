local servers = {
	-- Lua language server
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

	-- C/C++ via Clangd
	clangd = {
		cmd = {
			"clangd",
			"--background-index",
			"--clang-tidy",
			"--completion-style=detailed",
			"--header-insertion=iwyu",
			"--cross-file-rename",
			"--compile-commands-dir=build",
		},
		filetypes = { "c", "cpp", "objc", "objcpp" },
	},

	-- Python
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
}

NIXOS_FILE = "/etc/NIXOS"

return {
	"neovim/nvim-lspconfig",
	-- In NixOS, the lsp are download by the user
	dependencies = {
		{
			"williamboman/mason.nvim",
			enabled = function()
				return not vim.uv.fs_stat(NIXOS_FILE)
			end,
		},
		{
			"williamboman/mason-lspconfig.nvim",
			enabled = function()
				return not vim.uv.fs_stat(NIXOS_FILE)
			end,
		},
	},

	config = function()
		if (not vim.uv.fs_stat(NIXOS_FILE)) then
			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = vim.tbl_keys(servers),
			})
		end

		local capabilities = {}

		for name, config in pairs(servers) do
			config.capabilities = capabilities
			config.on_attach = function(client, bufnr)
				-- Add your keymaps here
				local opts = { buffer = bufnr }

				vim.keymap.set("n", "<leader>d", vim.diagnostic.setqflist, opts)
				vim.keymap.set("n", "grd", vim.lsp.buf.definition, opts)
				vim.keymap.set("n", "grD", vim.lsp.buf.declaration, opts)
				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
				vim.keymap.set("n", "gri", vim.lsp.buf.implementation, opts)
				vim.keymap.set("n", "grn", vim.lsp.buf.rename, opts)
			end

			vim.lsp.config(name, config)
		end
	end,
}
