local M = {}

M.open_files_vscode = function()
    Snacks.picker.files({
        layout = {
            preset = "vscode"
        }
    })
end

return M
