local M = {}

M.files_vscode = function()
    Snacks.picker.files({
        layout = {
            preset = "vscode"
        }
    })
end

M.all_files_vscode = function()
    Snacks.picker.files({
        layout = {
            preset = "vscode"
        },
        hidden = true,
        ignored = true,
        follow = true
    })
end

M.files = function()
    Snacks.picker.files()
end

M.all_files = function()
    Snacks.picker.files({
        hidden = true,
        ignored = true,
        follow = true
    })
end

M.git_files = function()
    Snacks.picker.git_files()
end

M.all_git_files = function()
    Snacks.picker.git_files({
        hidden = true,
        ignored = true,
        follow = true
    })
end

M.grep_string = function()
    Snacks.picker.grep()
end

M.all_grep_string = function()
    Snacks.picker.grep({
        hidden = true,
        ignored = true,
        follow = true
    })
end

return M
