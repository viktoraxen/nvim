local M = {}

M.find_files = function(args)
    local include_patterns = args.include or { "*" }
    local exclude_patterns = args.exclude or { "*/build/*", "*/test/*", "*/tests/*", "*/.git/*" }
    local dir = args.dir or vim.fn.getcwd()

    local command = "find " .. dir .. " -type f \\("

    for i, pattern in ipairs(include_patterns) do
        command = command .. " -name \"" .. pattern .. "\""

        if i < #include_patterns then
            command = command .. " -o"
        end
    end

    command = command .. " \\)"
    command = command .. " -not \\("

    for i, pattern in ipairs(exclude_patterns) do
        command = command .. " -wholename \"" .. pattern .. "\""

        if i < #exclude_patterns then
            command = command .. " -o"
        end
    end

    command = command .. " \\)"

    local files = {}

    for file in io.popen(command):lines() do
        table.insert(files, file)
    end

    return files
end

M.file_exists = function(filename)
    local file = vim.fn.getcwd() .. "/" .. filename
    local stat = vim.uv.fs_stat(file)
    return stat and stat.type == "file"
end

M.directory_exists = function(directory)
    local file = vim.fn.getcwd() .. directory
    local stat = vim.uv.fs_stat(file)
    return stat and stat.type == "directory"
end

return M
