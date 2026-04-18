vim.schedule(function()
  vim.pack.add({
    {
      src = "https://github.com/igorlfs/nvim-dap-view",
      version = vim.version.range("1"),
    },
    "https://codeberg.org/mfussenegger/nvim-dap",
    "https://codeberg.org/mfussenegger/nvim-dap-python",
  })

  require("dap-python").setup("uv")

  local dap = require("dap")
  local utils = require("utils")

  table.insert(dap.configurations.python, 1, {
    type = "python",
    request = "launch",
    name = "Launch file (prompt)",
    program = function()
      local co = coroutine.running()

      utils.centered_input("Path:", function(value)
        coroutine.resume(co, value)
      end)

      return coroutine.yield() or dap.ABORT
    end,
    cwd = "${workspaceFolder}",
  })

  require("dap-view").setup({
    winbar = {
      default_section = "scopes",
      controls = {
        enabled = true,
      },
    },
    windows = {
      size = 0.3,
      position = "right",
      terminal = {
        position = "below",
      },
    },
    icons = {
      disabled = "󰅚",
      enabled = "󰗡",
      filter = "󰈳",
      negate = "󰍷 ",
    },
    help = { border = "solid" },
    virtual_text = { enabled = true },
    auto_toggle = true,
    follow_tab = true,
    render = {
      breakpoints = { align = true },
    },
  })

  local hl = require("highlight-utils")
  hl.set({
    DapBreakpointRejected = { fg = hl.fg("Comment") },
  })

  vim.fn.sign_define("DapBreakpoint", { text = "󰻃", texthl = "DiagnosticError" })
  vim.fn.sign_define("DapBreakpointCondition", { text = "󰄰", texthl = "DiagnosticError" })
  vim.fn.sign_define("DapLogPoint", { text = "󰝶", texthl = "DiagnosticInfo" })
  vim.fn.sign_define("DapStopped", { text = "󰁔", texthl = "DiagnosticHint" })
  vim.fn.sign_define("DapBreakpointRejected", { text = "󰻃", texthl = "DapBreakpointRejected" })

  local function toggle_conditional()
    utils.centered_input("Condition:", function(value)
      if value and value ~= "" then
        dap.set_breakpoint(value)
      end
    end)
  end

  local function add_log_point()
    utils.centered_input("Log message:", function(value)
      if value and value ~= "" then
        dap.set_breakpoint(nil, nil, value)
      end
    end)
  end

  require("which-key").add({
    mode = { "n" },

    { "<left>", "<cmd>DapStepOut<cr>", desc = "Step out 󰨰" },
    { "<down>", "<cmd>DapStepOver<cr>", desc = "Step over 󰨰" },
    { "<up>", "<cmd>DapRestartFrame<cr>", desc = "Restart frame 󰨰" },
    { "<right>", "<cmd>DapStepInto<cr>", desc = "Step into 󰨰" },

    { "<leader>d", group = "Debug" },

    { "<leader>db", "<cmd>DapToggleBreakpoint<cr>", desc = "Toggle breakpoint" },
    { "<leader>dB", toggle_conditional, desc = "Toggle conditional breakpoint" },
    { "<leader>dc", "<cmd>DapContinue<cr>", desc = "Continue" },
    { "<leader>dd", "<cmd>DapStepOver<cr>", desc = "Step over" },
    { "<leader>di", "<cmd>DapStepInto<cr>", desc = "Step into" },
    { "<leader>dl", add_log_point, desc = "Add log point" },
    { "<leader>do", "<cmd>DapStepOut<cr>", desc = "Step out" },
    { "<leader>dt", "<cmd>DapTerminate<cr>", desc = "Terminate" },
    { "<leader>dw", "<cmd>DapViewWatch<cr>", desc = "Watch variable under cursor" },
  })
end)
