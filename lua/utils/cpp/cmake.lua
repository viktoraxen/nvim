local M = {}

local files = require("utils.files")
local job = require("utils.job")
local build_dir = "build"

M.is_cmake_project = function()
    return files.file_exists(vim.uv.cwd() .. "/CMakeLists.txt")
end


local target_file = function()
    if not M.is_cmake_project() then return end

    local lines = {}
    local target_name = nil

    local cmake_path = vim.uv.cwd() .. "/CMakeLists.txt"

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


local clean_task = function(args)
    return {
        name = "Clean",
        command = {
            "rm", "-rf", build_dir
        },
    }
end


local generate_task = function(args)
    args = args or {}
    local debug = args.debug or false
    local ninja = vim.fn.executable("ninja")

    local generator = ninja and "Ninja" or "Unix Makefiles"
    local build_type = debug and "Debug" or "Release"

    return {
        name = "CMake",
        command = {
            "cmake",
            "-S", ".",
            "-B", build_dir,
            "-G", generator,
            "-DCMAKE_BUILD_TYPE=" .. build_type
        },
    }
end


local build_task = function(args)
    args = args or {}
    local ninja = vim.fn.executable("ninja")
    local command = ninja and "ninja" or "make"
    local name = ninja and "Ninja" or "Make"

    return {
        name = name,
        command = {
            command, "-C", build_dir
        },
    }
end


M.run_debugger = function(args)
    local target = target_file()

    if not target then
        vim.notify("Could not find target file", vim.log.levels.ERROR)
        return
    end

    local target_path = vim.uv.cwd() .. "/" .. build_dir .. "/" .. target

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
end


M.run_float = function()
    local target = target_file()

    if not target then
        vim.notify("Could not find target file", vim.log.levels.ERROR)
        return
    end

    local target_path = vim.uv.cwd() .. "/" .. build_dir .. "/" .. target

    require("snacks").terminal(target_path, { auto_close = false })
end


M.start_sequence = function(args)
    local co = coroutine.create(function(args)
        args = args or {}
        local co = args.co or nil
        local clean = args.clean or false
        local generate = args.generate or false
        local build = args.build or false
        local run_mode = args.run or "none"
        local debug = run_mode == "debug" or (args.debug or false)

        local tasks = {}

        if clean then
            table.insert(tasks, clean_task())
        end

        if generate then
            table.insert(tasks, generate_task({
                debug = debug,
            }))
        end

        if build then
            table.insert(tasks, build_task())
        end

        for _, task in ipairs(tasks) do
            job.start(task, co)

            coroutine.yield()
        end

        if run_mode == "float" then
            M.run_float()
        elseif run_mode == "debug" then
            M.run_debugger()
        end
    end)

    args.co = co

    coroutine.resume(co, args)
end


M.clean = function()
    M.start_sequence({
        clean = true,
    })
end


M.generate = function()
    M.start_sequence({
        generate = true,
    })
end


M.build = function()
    M.start_sequence({
        build = true,
    })
end


M.clean_build = function(debug)
    M.start_sequence({
        clean = true,
        generate = true,
        build = true,
        debug = debug or false,
    })
end


M.generate_and_run_float = function(debug)
    M.start_sequence({
        generate = true,
        build = true,
        debug = debug or false,
        run = "float",
    })
end


M.generate_and_run_debug = function()
    M.start_sequence({
        generate = true,
        build = true,
        run = "debug",
    })
end


M.build_and_run_float = function()
    M.start_sequence({
        build = true,
        run = "float",
    })
end


M.build_and_run_debug = function()
    M.start_sequence({
        build = true,
        run = "debug",
    })
end


M.clean_run_float = function(debug)
    M.start_sequence({
        clean = true,
        generate = true,
        build = true,
        debug = debug or false,
        run = "float",
    })
end


M.clean_run_debugger = function()
    M.start_sequence({
        clean = true,
        generate = true,
        build = true,
        run = "debug",
    })
end

return M
