local M = {}

local base = ...

local filetype_func = function(filetype, func_name)
    local module = require(base .. "." .. filetype)
    local func = module[func_name]

    if not func then
        vim.notify("No " .. func_name .. " action for filetype \'" .. filetype .. "\'", vim.log.levels.WARN)
        return
    end

    return func
end


M.run_current = function()
    local filetype = vim.bo.filetype
    filetype_func(filetype, "run")()
end


M.debug_current = function()
    local filetype = vim.bo.filetype
    filetype_func(filetype, "debug")()
end

return M
