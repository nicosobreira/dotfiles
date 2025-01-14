-- local cmp = require("cmp")
-- local conf
return {
	"hrsh7th/nvim-cmp",
	enabled = false,
	opts = function()
		conf = require("nvchad.configs.cmp")
		conf.completion = {
			autocomplete = false,
		}
		conf.mapping = {
			["<C-p>"] = cmp.mapping.select_prev_item(),
			["<C-n>"] = cmp.mapping.select_next_item(),
			["<C-y>"] = cmp.mapping.confirm({
				behavior = cmp.ConfirmBehavior.Replace,
				select = true,
			}),
		}
		return conf
	end,
	config = function()
		cmp.setup(conf)
	end,
}
