local M = {}

local files = require("utils.files")
local async = require("plenary.async")

local build = async.void(function(output_name, debug)
    output_name = output_name or ".out"

    local source_files = files.find_files({
        include = { "*.cpp", "*.c" },
        exclude = { "*/build/*", "*/test/*", "*/tests/*", "*/.git/*" },
    })

    if #source_files == 0 then
        vim.notify("No source files found!", vim.log.levels.WARN)
        return
    end

    local command = "g++"

    if debug then
        command = command .. " -g "
    end

    for i, file in ipairs(source_files) do
        command = command .. file

        if i < #source_files then
            command = command .. " "
        end
    end

    command = command .. " -I include -I ."
    command = command .. " -o " .. output_name

    local job = vim.system(vim.fn.split(command), {
        text = true,
    }, function(res)
        vim.schedule(function()
            if res.code == 0 then
                vim.notify("Compiled successfully!", vim.log.levels.INFO)
            else
                vim.notify("Compilation failed:\n" .. res.stderr, vim.log.levels.ERROR)
            end
        end)
    end)

    return job
end)

M.build_debug = function(output_name)
    return build(output_name, true)
end

M.build_release = function(output_name)
    return build(output_name, false)
end

M.build_and_debug = function()
    local compile_job = M.build_debug(".out")

    if not compile_job then
        vim.notify("Build failed! (Failed to start job)", vim.log.levels.ERROR)
        return
    end

    local result = compile_job:wait()

    require("dap").run({
        type = "codelldb",
        request = "launch",
        program = ".out",
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
    })
end

return M
