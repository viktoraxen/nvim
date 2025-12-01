return {
  "mfussenegger/nvim-dap",
  lazy = true,
  config = function()
    local map = require("utils.keymap")
    local dap = require("dap")

    map.l_group("d", "Debug")

    dap.adapters.codelldb = {
      type = "server",
      port = "${port}",
      executable = {
        command = "codelldb",
        args = { "--port", "${port}" },
      },
    }

    dap.adapters.python = {
      type = "executable",
      command = "python3",
      args = { "-m", "debugpy.adapter" },
    }

    dap.configurations.python = {
      {
        type = "python",
        request = "launch",
        name = "Launch file",
        program = "${file}", -- This will debug the current file
        pythonPath = function()
          return "python3"
        end,
      },
    }

    dap.configurations.cpp = {
      {
        name = "Launch file",
        type = "codelldb",
        request = "launch",
        program = function()
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
      },
    }

    vim.fn.sign_define("DapBreakpoint", {
      text = "",
      texthl = "DapBreakpoint",
      linehl = "",
      numhl = "",
    })

    vim.fn.sign_define("DapStopped", {
      text = "",
      texthl = "DapStopped",
      linehl = "Visual",
      numhl = "",
    })

    vim.fn.sign_define("DapBreakpointRejected", {
      text = "",
      texthl = "ErrorMsg",
      linehl = "",
      numhl = "",
    })
  end,
}
