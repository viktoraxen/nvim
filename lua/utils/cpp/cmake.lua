local M = {}

local files = require("utils.files")
local async = require("plenary.async")
local job = require("plenary.job")

M.is_cmake_project = function()
    return files.file_exists("CMakeLists.txt")
end

M.target_file = function()
    if not M.is_cmake_project() then return end

    local lines = {}
    local target_name = nil

    local cmake_path = vim.fn.getcwd() .. "/CMakeLists.txt"

    local file = io.open(cmake_path, "r")

    if not file then
        vim.notify("CMakeLists.txt not found at: " .. cmake_path, vim.log.levels.ERROR)
        return nil
    end

    for line in file:lines() do
        table.insert(lines, line)
    end

    file:close()

    for _, line in ipairs(lines) do
        local code = line:match("^[^#]*")

        local match = code:match("add_executable%s*%((%S+)")

        if match then
            target_name = match
            break
        end
    end

    return target_name
end

local build_job = function(args)
    local debug = args.debug or false
    local clean = args.clean or false
    local ninja = vim.fn.executable("ninja")

    if files.directory_exists("build") then
        if clean then vim.fn.system("rm -rf build") end
    else
        vim.fn.system("mkdir build")
    end

    local generator = ninja and "Ninja" or "Unix Makefiles"
    local build_type = debug and "Debug" or "Release"

    local cmake_stderr = {}

    local cmake_job = job:new({
        command = "cmake",
        args = {
            "-S", ".",
            "-B", "build",
            "-G", generator,
            "-DCMAKE_BUILD_TYPE=" .. build_type
        },
        on_stderr = function(_, data)
            if data then
                table.insert(cmake_stderr, data)
            end
        end,
        on_exit = function(j, code, signal)
            if code ~= 0 then
                vim.schedule(function()
                    vim.notify("CMake failed! Exit code " .. code, vim.log.levels.ERROR)

                    if #cmake_stderr ~= 0 then
                        vim.notify("CMake output: \n" .. table.concat(cmake_stderr, "\n"))
                    end
                end)
            end
        end
    })

    local generator_stderr = {}

    local generator_job = job:new({
        command = ninja and "ninja" or "make",
        args = {
            "-C", "build"
        },
        on_stderr = function(_, data)
            if data then
                table.insert(generator_stderr, data)
            end
        end,
        on_exit = function(j, code, signal)
            if code ~= 0 then
                vim.schedule(function()
                    vim.notify("Make failed! Exit code " .. code, vim.log.levels.ERROR)

                    if #generator_stderr ~= 0 then
                        vim.notify("Make output: \n" .. table.concat(generator_stderr, "\n"))
                    end
                end)

                return
            end
        end
    })

    cmake_job:and_then_on_success(generator_job)

    return cmake_job
end


M.build_and_debug = function()
    local j = build_job({
        debug = true
    })

    j:after_success(function()
        vim.schedule(function()
            vim.notify("Build successful!", vim.log.levels.INFO)

            local target = M.target_file()
            local target_path = "build/" .. target

            if not files.file_exists(target_path) then
                vim.notify("Could not find target file \'" .. target_path .. "\'", vim.log.levels.ERROR)
                return
            end

            require("dap").run({
                type = "codelldb",
                request = "launch",
                program = target_path,
                cwd = "${workspaceFolder}",
                stopOnEntry = false,
            })
        end)
    end)

    j:start()
end

return M
