local M = {}

local job = require("plenary.job")

M.notifying = function(args)
    local command = args.command
    local cmd_args = args.args
    local name = args.name

    local stderr = {}

    local notifying_job = job:new({
        command = command,
        args = cmd_args,
        on_stderr = function(_, data)
            if data then
                table.insert(stderr, data)
            end
        end,
        on_exit = function(_, code, _)
            if code ~= 0 then
                vim.schedule(function()
                    vim.notify(name .. " failed! Exit code " .. code, vim.log.levels.ERROR)

                    if #stderr ~= 0 then
                        vim.notify(name .. " output: \n" .. table.concat(stderr, "\n"))
                    end
                end)
            else
                vim.schedule(function()
                    vim.notify(name .. " completed successfully!", vim.log.levels.INFO)
                end)
            end
        end
    })

    return notifying_job
end

return M
