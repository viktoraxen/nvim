local M = {}

M.cpp = function()
    local cmake = require("utils.cpp.cmake")
    local gpp = require("utils.cpp.gpp")

    if cmake.is_cmake_project() then
        cmake.build_and_debug()
    else
        gpp.build_and_debug()
    end
end

M.current = function()
    local filetype = vim.bo.filetype

    if not M[filetype] then
        vim.notify("No debug action for filetype \'" .. filetype .. "\'", vim.log.levels.WARN)
        return
    end

    M[filetype]()
end

return M
