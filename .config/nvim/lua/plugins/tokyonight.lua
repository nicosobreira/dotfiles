return {
	'folke/tokyonight.nvim',
	lazy = false, -- make sure the colorscheme is loaded immediately
	priority = 1000, -- load this before all other plugins
	config = function()
		require("tokyonight").load()
	end,
}
