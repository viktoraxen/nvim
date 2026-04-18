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

  table.insert(dap.configurations.python, 1, {
    type = "python",
    request = "launch",
    name = "Launch file (prompt)",
    program = function()
      local co = coroutine.running()
      local width = 60
      Snacks.input({
        prompt = "Path",
        default = vim.fn.getcwd() .. "/",
        completion = "file",
        win = {
          relative = "editor",
          width = width,
          row = math.floor((vim.o.lines - 3) / 2),
          col = math.floor((vim.o.columns - width - 2) / 2),
        },
      }, function(value)
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
      size = 0.4,
      position = "right",
      terminal = {
        position = "below",
      },
    },
    help = { border = "solid" },
    virtual_text = { enabled = true },
    auto_toggle = true,
    follow_tab = true,
  })

  require("which-key").add({
    mode = { "n" },

    { "<left>", "<cmd>DapStepOut<cr>", desc = "Step out 󰨰" },
    { "<down>", "<cmd>DapStepOver<cr>", desc = "Step over 󰨰" },
    { "<up>", "<cmd>DapRestartFrame<cr>", desc = "Restart frame 󰨰" },
    { "<right>", "<cmd>DapStepInto<cr>", desc = "Step into 󰨰" },

    { "<leader>d", group = "Debug" },

    { "<leader>db", "<cmd>DapToggleBreakpoint<cr>", desc = "Toggle breakpoint" },
    { "<leader>dc", "<cmd>DapContinue<cr>", desc = "Continue" },
    { "<leader>dd", "<cmd>DapStepOver<cr>", desc = "Step over" },
    { "<leader>di", "<cmd>DapStepInto<cr>", desc = "Step into" },
    { "<leader>do", "<cmd>DapStepOut<cr>", desc = "Step out" },
    { "<leader>dt", "<cmd>DapTerminate<cr>", desc = "Terminate" },
    { "<leader>dw", "<cmd>DapViewWatch<cr>", desc = "Watch variable under cursor" },
  })
end)
