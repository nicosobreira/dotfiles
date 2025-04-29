return {
	"iamcco/markdown-preview.nvim",
	cond = function()
		return vim.fn.executable("nodejs") == 1
	end,
	ft = { "markdown" },
	cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
	build = function() vim.fn["mkdp#util#install"]() end,
	keys = {
		{
			"<leader>.",
			"<cmd>MarkdownPreviewToggle<CR>",
			desc = "Markdown preview",
		},
	},
}
