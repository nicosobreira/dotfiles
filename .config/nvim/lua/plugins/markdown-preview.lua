return {
	"iamcco/markdown-preview.nvim",
	cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
	ft = { "markdown" },
	build = function() vim.fn["mkdp#util#install"]() end,
	cond = function()
		return vim.fn.executable("nodejs") == 1
	end,
	keys = {
		{
			"<leader>.",
			"<cmd>MarkdownPreviewToggle<CR>",
			desc = "Markdown preview",
		},
	},
}
