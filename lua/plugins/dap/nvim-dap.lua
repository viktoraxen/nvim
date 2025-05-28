return {
    "mfussenegger/nvim-dap",
    lazy = true,
    keys = {
        { "<leader>db", "<cmd>DapToggleBreakpoint<cr>", desc = "Breakpoint" },
        { "<leader>dD", "<cmd>DapContinue<cr>",         desc = "Continue" },
        { "<leader>di", "<cmd>DapStepInto<cr>",         desc = "Step Into" },
        { "<leader>do", "<cmd>DapStepOut<cr>",          desc = "Step Out" },
        { "<leader>ds", "<cmd>DapStepOver<cr>",         desc = "Step Over" },
        { "<leader>dt", "<cmd>DapTerminate<cr>",        desc = "Terminate" },
        { "<leader>dq", "<cmd>DapTerminate<cr>",        desc = "Terminate" },
    },
    config = function()
        local dap = require('dap')

        dap.adapters.codelldb = {
            type = 'server',
            port = '${port}',
            executable = {
                command = 'codelldb',
                args = { '--port', '${port}' }
            },
        }

        dap.adapters.python = {
            type = 'executable',
            command = 'python3',
            args = { '-m', 'debugpy.adapter' },
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
            numhl = ""
        })

        vim.fn.sign_define("DapStopped", {
            text = "",
            texthl = "DapStopped",
            linehl = "Visual",
            numhl = ""
        })

        vim.fn.sign_define("DapBreakpointRejected", {
            text = "",
            texthl = "ErrorMsg",
            linehl = "",
            numhl = ""
        })
    end,
}
