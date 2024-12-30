return {
	"stevearc/conform.nvim",
	event = "BufWritePre",
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			c = { "clang-format" },
		},
		format_on_save = {
			-- These options will be passed to conform.format()
			lsp_format = "fallback",
		},
		-- formatters = {
		-- 	my_clang_format = {
		-- 		command = "clang-format",
		-- 		-- append_args = '--style=file --fallback-style="{BasedOnStyle: llvm, IndentWidth: 4}"',
		-- 		append_args = { "-style=file", '-fallback-style="{BasedOnStyle: LLVM, IndentWidth: 4}"' },
		-- 		-- prepend_args = { "-i", "4" },
		-- 	},
		-- },
	},
}
