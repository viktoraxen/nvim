local M = {}

M.gitter = function(item, _)
    local x, y = item.status:match("^(.)(.)$")

    local status = x ~= " " and x or y
    local staged = x ~= " " and x ~= "?"

    local icons = {
        ["M"] = '󰜥',
        ["A"] = '',
        ["D"] = '󰧧',
        ["R"] = '',
        ["C"] = '',
        ["U"] = '',
        ["?"] = '',
    }

    local highlights = {
        ["M"] = "Modified",
        ["A"] = "Added",
        ["D"] = "Deleted",
        ["R"] = "Renamed",
        ["C"] = "Copied",
        ["U"] = "Unmerged",
        ["?"] = "Untracked",
    }

    local icon = icons[status]

    local icon_hl = "SnacksPickerGitStatus" .. highlights[status]
    local file_hl = staged and "SnacksPickerGitStatusStaged" or "SnacksPickerFile"
    local path_hl = staged and "SnacksPickerDimmed" or "SnacksPickerPathHidden"

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
