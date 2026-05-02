return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
		"theHamsta/nvim-dap-virtual-text",
	},
	cmd = { "DapNew" },
	lazy = true,
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		require("nvim-dap-virtual-text").setup()
		dapui.setup()

		dap.listeners.after.event_initialized["dapui_config"] = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated["dapui_config"] = function()
			dapui.close()
		end
		dap.listeners.before.event_exited["dapui_config"] = function()
			dapui.close()
		end

		dap.adapters.lldb = {
			type = "executable",
			command = "lldb-dap",
			name = "lldb",
		}

		dap.configurations.rust = {
			{
				name = "Debug with Cargo (Auto-Find)",
				type = "lldb",
				request = "launch",
				program = function()
					local cwd = vim.fn.getcwd()
					local project_name = vim.fn.fnamemodify(cwd, ":t")

					local target_path = cwd .. "/target/debug/" .. project_name

					if vim.fn.filereadable(target_path) == 1 then
						return target_path
					else
						print("Couldn't find the program in: " .. target_path)
						print("Try running `cargo build` first")
						return vim.fn.input("Program executable: ", cwd .. "/target/debug/", "file")
					end
				end,
				cwd = "${workspaceFolder}",
				stopOnEntry = false,
				terminal = "integrated",
			},
		}
	end,

	keys = {
		{
			"<leader>db",
			function()
				require("dap").toggle_breakpoint()
			end,
			desc = "[d]ebugger [b]reak",
		},
		{
			"<leader>dc",
			function()
				require("dap").continue()
			end,
			desc = "[d]ebugger [c]ontinue",
		},
		{
			"<leader>dn",
			function()
				require("dap").step_over()
			end,
			desc = "[d]ebugger [n]ext",
		},
		{
			"<leader>ds",
			function()
				require("dap").step_into()
			end,
			desc = "[d]ebugger [s]tep into",
		},
		{
			"<leader>do",
			function()
				require("dap").step_out()
			end,
			desc = "[d]ebugger step [o]ut",
		},
		{
			"<leader>dq",
			function()
				require("dap").terminate()
			end,
			desc = "[d]ebugger [q]uit",
		},
	},
}
