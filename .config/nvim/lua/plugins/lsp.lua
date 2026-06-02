local SERVERS = {
	zls = {},

	rust_analyzer = {
		settings = {
			check = { command = "clippy" },
		},
	},

	nil_ls = {
		settings = {
			["nil"] = {
				nix = {
					flake = {
						autoArchive = true,
					},
				},
			},
		},
	},
	cmake = {},
	bashls = {},
	c3_lsp = {
		cmd = { "c3-lsp" },
		filetypes = { "c3", "c3i" },
		root_markers = { "project.json", ".git" },
	},
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
		filetypes = { "c", "cpp", "h", "hpp", "objc", "objcpp", "cuda" },
		cmd = {
			"clangd",
			"--clang-tidy",
			"--background-index",
			"--header-insertion=iwyu",
			"--cross-file-rename",
			"--compile-commands-dir=build",
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
}

local function on_attach(_, bufnr)
	local opts = { buffer = bufnr, silent = true }

	vim.keymap.set("n", "<leader>d", vim.diagnostic.setqflist, opts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
	vim.keymap.set("n", "gra", vim.lsp.buf.code_action, opts)
	vim.keymap.set("n", "grd", vim.lsp.buf.definition, opts)
	vim.keymap.set("n", "grD", vim.lsp.buf.declaration, opts)
	vim.keymap.set("n", "gri", vim.lsp.buf.implementation, opts)
	vim.keymap.set("n", "grn", vim.lsp.buf.rename, opts)
end

--- In NixOS, the lsp are download by the user
local is_nixos = vim.uv.fs_stat("/etc/NIXOS")

local use_mason = not is_nixos

return {
	"neovim/nvim-lspconfig",
	dependencies = use_mason and {
		{ "williamboman/mason.nvim" },
		{ "williamboman/mason-lspconfig.nvim" },
	} or {},

	config = function()
		if use_mason then
			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = vim.tbl_keys(SERVERS),
				automatic_installation = true,
			})
		end

		vim.lsp.set_log_level("off")

		local capabilities = {}

		local default_config = { on_attach = on_attach, capabilities = capabilities }

		for name, config in pairs(SERVERS) do
			config = vim.tbl_deep_extend("force", default_config, config or {})

			vim.lsp.config(name, config)
			vim.lsp.enable(name)
		end
	end,
}
