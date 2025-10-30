local M = {}

M.gitter = function(item, _)
    local x, y   = item.status:match("^(.)(.)$")

    local status = x ~= " " and x or y
    local staged = (x ~= " " and x ~= "?" and "Staged") or "Unstaged"

    if staged == "Staged" and y ~= " " then
        staged = "Partially"
    end

    local icons = {
        ["M"] = '󰜥',
        ["A"] = '',
        ["D"] = '󰧧',
        ["R"] = '',
        ["C"] = '',
        ["U"] = '',
        ["T"] = '',
        ["?"] = '',
    }

    local icon_highlights = {
        ["M"] = "Modified",
        ["A"] = "Added",
        ["D"] = "Deleted",
        ["R"] = "Renamed",
        ["C"] = "Copied",
        ["T"] = 'Copied',
        ["U"] = "Unmerged",
        ["?"] = "Untracked",
    }

    local file_highlights = {
        ["Unstaged"] = "SnacksPickerFile",
        ["Partially"] = "SnacksPickerGitStatusModified",
        ["Staged"] = "SnacksPickerGitStatusStaged",
    }

    local icon = icons[status] or ' '

    local icon_hl = "SnacksPickerGitStatus" .. (icon_highlights[status] or "Unstaged")
    local file_hl = file_highlights[staged]
    local path_hl = staged == "Unstaged" and "SnacksPickerPathHidden" or "SnacksPickerDimmed"

    local ret = {
        { icon .. " ", icon_hl, true },
    }

    if item.rename then
        table.insert(ret, { vim.fs.basename(item.rename), file_hl })

        local path = vim.fs.dirname(item.file)

        if path then
            table.insert(ret, { " ", "SnacksPickerComment", true })
            table.insert(ret, { path, path_hl })
        end

        table.insert(ret, { "  ", "SnacksPickerGitStatusRenamed", true })
    end

    table.insert(ret, { vim.fs.basename(item.file), file_hl })

    local path = vim.fs.dirname(item.file)

    if path then
        table.insert(ret, { " ", "SnacksPickerComment", true })
        table.insert(ret, { path, path_hl })
    end

    return ret
end

return M
