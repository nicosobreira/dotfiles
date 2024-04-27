return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
	  "nvim-lua/plenary.nvim",
	  "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
	  "MunifTanjim/nui.nvim",
	},
	config = function()
		map('n', '<leader>n', ':NeoTree filesystem reveal right<cr>')
		require("neo-tree").setup({
			window = {
				position = "right",
				width = 26,
			}
		})
	end
}
