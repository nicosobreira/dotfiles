return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",
  },
  keys = {
    { "n", "<leader>dx", ":DapTerminate<CR>", desc = "Toggle UI" },
    { "n", "<leader>db", ":DapToggleBreakpoint<CR>", desc = "Toggle Breakpoint" },
    { "n", "<leader>dc", ":DapContinue<CR>", desc = "Continue debugger" },
  },
  config = function()
    local dap = require "dap"
    local dapui = require "dapui"

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
  end,
}
