local M = {}

M.start = function(args, co)
    local command = args.command or ""
    local name = args.name or "Async Task"
    local on_start = args.on_start or function() end
    local on_failure = args.on_failure or function(_, _) end
    local on_success = args.on_success or function() end

    local stderr = ""

    on_start()

    vim.fn.jobstart(command, {
        on_stderr = function(_, data)
            if data then
                for _, line in ipairs(data) do
                    if line ~= "" then stderr = stderr .. line .. "\n" end
                end
            end
        end,
        on_exit = vim.schedule_wrap(function(_, code, _)
            if code ~= 0 then
                on_failure(code, stderr)
            else
                on_success()
            end

            if co then
                coroutine.resume(co, code)
            end
        end)
    })
end

return M
