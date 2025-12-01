---@diagnostic disable: missing-fields
return {
  "rcarriga/nvim-dap-ui",
  dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
  keys = {
    { "<leader>db", "<cmd>DapToggleBreakpoint<cr>", desc = "Breakpoint" },
    { "<leader>dD", "<cmd>DapContinue<cr>", desc = "Continue" },
  },
  opts = {
    expand_lines = true,
    icons = { expanded = "", collapsed = "", circular = "" },
    mappings = {
      -- Use a table to apply multiple mappings
      expand = { "<CR>", "<2-LeftMouse>" },
      open = "o",
      remove = "d",
      edit = "e",
      repl = "r",
      toggle = "t",
    },
    layouts = {
      {
        elements = {
          { id = "watches", size = 0.25 },
          { id = "scopes", size = 0.25 },
          { id = "breakpoints", size = 0.25 },
          { id = "stacks", size = 0.25 },
        },
        size = 0.33,
        position = "right",
      },
      {
        elements = {
          { id = "repl", size = 0.5 },
          { id = "console", size = 0.5 },
        },
        size = 0.33,
        position = "bottom",
      },
    },
    floating = {
      max_height = 0.88,
      max_width = 0.89, -- Floats will be treated as percentage of your screen.
      border = "rounded", -- Border style. Can be "single", "double", "shadow", or "rounded"
      mappings = {
        close = { "q", "<Esc>" },
      },
    },
  },
  config = function(_, opts)
    local dap, dapui = require("dap"), require("dapui")
    local map = require("utils.keymap")

    map.n("<leader>di", "<cmd>DapStepInto<cr>", "Step Into")
    map.n("<leader>do", "<cmd>DapStepOut<cr>", "Step Out")
    map.n("<leader>ds", "<cmd>DapStepOver<cr>", "Step Over")
    map.n("<leader>dt", "<cmd>DapTerminate<cr>", "Terminate")
    map.n("<leader>dq", "<cmd>DapTerminate<cr>", "Terminate")

    dapui.setup(opts)

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
