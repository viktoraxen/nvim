local M = {}

M.start = function(args, co)
    local command = args.command or ""
    local name = args.name or "Async Task"

    local stderr = {}

    vim.fn.jobstart(command, {
        on_stderr = function(_, data)
            if data then
                for _, line in ipairs(data) do
                    if line ~= "" then table.insert(stderr, line) end
                end
            end
        end,
        on_exit = vim.schedule_wrap(function(_, code, _)
            if code ~= 0 then
                vim.notify(name .. " failed! exit code " .. code, vim.log.levels.error)

                if #stderr ~= 0 then
                    vim.notify(name .. " output: \n" .. table.concat(stderr, "\n"))
                end
            end

            if co then
                coroutine.resume(co, code)
            end
        end)
    })
end

return M
