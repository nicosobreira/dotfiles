return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	version = false,
	lazy = false,
	build = ":TSUpdate",
	-- init = function(plugin)
	-- 	require("lazy.core.loader").add_to_rtp(plugin)
	-- 	require("nvim-treesitter.query_predicates")
	-- end,
	cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
	opts = {
		highlight = { enable = true },
		indent = { enable = true },
		ensure_installed = {
			"bash",
			"c",
			"c3",
			"diff",
			"html",
			"javascript",
			"jsdoc",
			"json",
			"lua",
			"luadoc",
			"luap",
			"markdown",
			"markdown_inline",
			"printf",
			"python",
			"query",
			"regex",
			"toml",
			"tsx",
			"typescript",
			"vim",
			"vimdoc",
			"xml",
			"yaml",
			"doxygen",
		},
	},
	config = function(_, opts)
		require("nvim-treesitter").setup()
		require("nvim-treesitter").install(opts.ensure_installed)

		vim.api.nvim_create_autocmd("FileType", {
			pattern = opts.ensure_installed,
			callback = function()
				-- Start Treesitter for this buffer
				require("vim.treesitter").start()

				-- Enable Treesitter-based folding
				vim.wo.foldmethod = "expr"
				vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"

				-- Enable Treesitter-based indentation
				vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end,
		})
	end,
}
