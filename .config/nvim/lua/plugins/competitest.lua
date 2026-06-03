return {
	"xeluxee/competitest.nvim",
	ft = { "python" },
	dependencies = "muniftanjim/nui.nvim",
	config = function()
		require("competitest").setup({
			local_testcases_use_single_file = true,
			save_current_file = true,
			testcases_directory = "testcases",
			compile_directory = ".",
			running_directory = ".",

			runner_ui = {
				interface = "popup",
			},
		})
	end,
	keys = {
		{ "<leader>tp", "<cmd>CompetiTest run<CR>", desc = "[T]est [C]ode" },
		{ "<leader>ta", "<cmd>CompetiTest add_testcase<CR>", desc = "[T]est [A]dd Case" },
		{ "<leader>te", "<cmd>CompetiTest edit_testcase<CR>", desc = "[T]est [E]dit Cases" },
		{ "<leader>tr", "<cmd>CompetiTest receive testcases<CR>", desc = "[T]est [R]eceive from Browser" },
	},
}
