local M = {}

M.debug = function()
    local current_file_path = vim.fn.expand('%:p')

    require('dap').run({
        type = 'python',
        request = 'launch',
        name = 'Debug Current File',
        program = current_file_path,
        layout = {
            elements = {
                {
                    elements = {
                        { id = "watches",     size = 0.25 },
                        { id = "scopes",      size = 0.25 },
                        { id = "breakpoints", size = 0.25 },
                        { id = "stacks",      size = 0.25 },
                    },
                    size = 0.33,
                    position = "right",
                },
                {
                    elements = {
                        { id = "repl", size = 0.5 },
                    },
                    size = 0.33,
                    position = "bottom",
                },
            }
        }
    })
end

M.run = function()
    local current_file_path = vim.fn.expand('%:p')

    local command_to_run = "python3 " .. vim.fn.shellescape(current_file_path)

    Snacks.terminal(command_to_run, { auto_close = false })
end

return M
