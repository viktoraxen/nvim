local M = {}

local files = require("utils.files")
local job = require("utils.job")

local target = ".out"

local notification_id = "cpp_cmake_build"
local notification_title = "C++ Project"
local notification_timeout = 2000

local build_task = function(args)
    args = args or {}
    local debug = args.debug or false
    local include_dir = files.directory_exists(vim.uv.cwd() .. "/include") and "include" or "."

    local source_files = files.find_files({
        include = { "*.cpp", "*.c" },
        exclude = { "*/build/*", "*/test/*", "*/tests/*", "*/.git/*" },
    })

    local command = {
        "g++",
        "-I", include_dir,
        "-o", target,
    }

    if debug then
        table.insert(command, "-g")
    end

    for _, file in ipairs(source_files) do
        table.insert(command, file)
    end

    return {
        name = "G++",
        command = command,
        on_start = function()
            Snacks.notify("Building binary...", {
                id = notification_id,
                title = notification_title,
                icon = "🔨",
                timeout = false,
            })
        end,
        on_success = function()
            Snacks.notify("Build finished!", {
                id = notification_id,
                title = notification_title,
                icon = "✅",
                timeout = notification_timeout,
            })
        end,
        on_failure = function(code, stderr)
            Snacks.notify("Build failed! Exit code " .. code .. "\n" .. stderr, {
                id = notification_id,
                title = notification_title,
                icon = "❌",
                timeout = false,
            })
        end,
    }
end


M.run_debugger = function()
    if not files.file_exists(vim.uv.cwd() .. "/" .. target) then
        vim.notify("Could not find target file \'" .. target .. "\'", vim.log.levels.ERROR)
        return
    end

    require("dap").run({
        type = "codelldb",
        request = "launch",
        program = target,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
    })
end


M.run_float = function()
    if not files.file_exists(vim.uv.cwd() .. "/" .. target) then
        vim.notify("Could not find target file \'" .. target .. "\'", vim.log.levels.ERROR)
        return
    end

    require("snacks").terminal("./" .. target, { auto_close = false })
end


M.start_sequence = function(args)
    local co = coroutine.create(function(args)
        args = args or {}
        local co = args.co or nil
        local build = args.build or false
        local run_mode = args.run or "none"
        local debug = run_mode == "debug" or (args.debug or false)

        if build then
            job.start(build_task({ debug = debug }), co)

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


M.build_and_run_debug = function()
    M.start_sequence({
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


return M
