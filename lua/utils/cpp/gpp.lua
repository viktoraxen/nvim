local M = {}

local files = require("utils.files")
local job = require("utils.job")

local build_job = function(args)
    args = args or {}
    local debug = args.debug or false
    local output_name = args.output_name or ".out"
    local include_dir = files.directory_exists("include") and "include" or "."

    local source_files = files.find_files({
        include = { "*.cpp", "*.c" },
        exclude = { "*/build/*", "*/test/*", "*/tests/*", "*/.git/*" },
    })

    args = {
        "-I", include_dir,
        "-o", output_name,
    }

    if debug then
        table.insert(args, "-g")
    end

    for _, file in ipairs(source_files) do
        table.insert(args, file)
    end

    local gpp_job = job.notifying({
        name = "G++",
        command = "g++",
        args = args,
    })

    return gpp_job
end


M.debug = function(args)
    args = args or {}
    local target = args.build_dir or ".out"

    vim.schedule(function()
        if not files.file_exists(target) then
            vim.notify("Could not find target file \'" .. target .. "\'", vim.log.levels.ERROR)
            return
        end

        vim.notify("Debugging target: " .. target, vim.log.levels.INFO)

        require("dap").run({
            type = "codelldb",
            request = "launch",
            program = target,
            cwd = "${workspaceFolder}",
            stopOnEntry = false,
        })
    end)
end


M.build = function()
    local result_job = build_job({ debug = false })
    result_job:start()
end


M.build_debug = function()
    local result_job = build_job({ debug = true })
    result_job:start()
end


M.build_and_debug = function()
    local result_job = build_job({ debug = true })
    result_job:after_success(M.debug)
    result_job:start()
end


return M
