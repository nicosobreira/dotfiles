return {
	"kylechui/nvim-surround",
	version = "^3.0.0", -- Use for stability; omit to use `main` branch for the latest features
	ft = "markdown",
	config = function()
		require("nvim-surround").setup({
			opts = {
				surrounds = {
					["b"] = {
						add = {"**", "**"},
					},
					["i"] = {
						add = {"*", "*"},
					}
				}
			}
		})
	end
}
