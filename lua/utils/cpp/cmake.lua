local M = {}

local files = require("utils.files")
local job = require("utils.job")

M.is_cmake_project = function()
    return files.file_exists("CMakeLists.txt")
end


local target_file = function()
    if not M.is_cmake_project() then return end

    local lines = {}
    local target_name = nil

    local cmake_path = vim.loop.cwd() .. "/CMakeLists.txt"

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


local clean_job = function(args)
    args = args or {}
    local build_dir = args.build_dir or "build"

    local clean_job = job.notifying({
        name = "Clean",
        command = "rm",
        args = {
            "-rf", build_dir
        },
    })

    return clean_job
end


local generate_job = function(args)
    args = args or {}
    local debug = args.debug or false
    local build_dir = args.build_dir or "build"
    local ninja = vim.fn.executable("ninja")

    local generator = ninja and "Ninja" or "Unix Makefiles"
    local build_type = debug and "Debug" or "Release"

    local cmake_job = job.notifying({
        name = "Generate",
        command = "cmake",
        args = {
            "-S", ".",
            "-B", build_dir,
            "-G", generator,
            "-DCMAKE_BUILD_TYPE=" .. build_type
        },
    })

    return cmake_job
end


local build_job = function(args)
    args = args or {}
    local build_dir = args.build_dir or "build"
    local ninja = vim.fn.executable("ninja")

    local make_job = job.notifying({
        name = "Build",
        command = ninja and "ninja" or "make",
        args = {
            "-C", build_dir
        },
    })

    return make_job
end


M.debug_target = function(args)
    args = args or {}
    local build_dir = args.build_dir or "build"

    local target = target_file()

    vim.schedule(function()
        if not target then
            vim.notify("Could not find target file", vim.log.levels.ERROR)
            return
        end

        local target_path = build_dir .. "/" .. target

        if not files.file_exists(target_path) then
            vim.notify("Could not find target file \'" .. target_path .. "\'", vim.log.levels.ERROR)
            return
        end

        vim.notify("Debugging target: " .. target_path, vim.log.levels.INFO)

        require("dap").run({
            type = "codelldb",
            request = "launch",
            program = target_path,
            cwd = "${workspaceFolder}",
            stopOnEntry = false,
        })
    end)
end


M.clean = function()
    local result_job = clean_job()
    result_job:start()
end


M.generate = function()
    local result_job = generate_job({ debug = false })
    result_job:start()
end


M.generate_debug = function()
    local result_job = generate_job({ debug = true })
    result_job:start()
end


M.build = function()
    local result_job = build_job()
    result_job:start()
end


M.debug = M.debug_target


M.clean_generate = function()
    local result_job = clean_job()
    result_job:and_then_on_success(generate_job())
    result_job:start()
end


M.generate_build = function()
    local result_job = generate_job()
    result_job:and_then_on_success(build_job())
    result_job:start()
end


M.build_debug = function()
    local result_job = build_job()
    result_job:after_success(M.debug_target)
    result_job:start()
end


M.clean_generate_build = function()
    local result_job = clean_job()
    result_job:and_then_on_success(generate_job())
    result_job:and_then_on_success(build_job())
    result_job:start()
end


M.generate_build_debug = function()
    local result_job = generate_job({ debug = true })
    result_job:and_then_on_success(build_job())
    result_job:after_success(M.debug_target)
    result_job:start()
end


M.clean_generate_build_debug = function()
    local result_job = clean_job()
    result_job:and_then_on_success(generate_job({ debug = true }))
    result_job:and_then_on_success(build_job())
    result_job:after_success(M.debug_target)
    result_job:start()
end


return M
