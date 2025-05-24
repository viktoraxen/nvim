local M = {}

M.debug = function()
    local cmake = require("utils.cpp.cmake")

    if cmake.is_cmake_project() then
        cmake.generate_and_run_debug()
    else
        local gpp = require("utils.cpp.gpp")

        gpp.build_and_run_debug()
    end
end


M.run = function()
    local cmake = require("utils.cpp.cmake")

    if cmake.is_cmake_project() then
        local files = require("utils.files")

        if files.directory_exists(vim.uv.cwd() .. "/build") then
            cmake.build_and_run_float()
        else
            cmake.generate_and_run_float()
        end
    else
        local gpp = require("utils.cpp.gpp")

        gpp.build_and_run_float()
    end
end


M.run_release = function()
    local cmake = require("utils.cpp.cmake")

    if cmake.is_cmake_project() then
        cmake.generate_and_run_float(false)
    else
        local gpp = require("utils.cpp.gpp")

        gpp.build_and_run_release()
    end
end


return M
