local M = {}

M.vscode = {
    layout = {
        preview = false,
        layout = {
            box = "vertical",
            row = 0.25,
            width = 0.5,
            min_width = 75,
            height = 0.4,
            backdrop = false,
            {
                win = "preview",
                title = "{preview}",
                height = 0.5,
                border = "solid",
            },
            {
                box = "vertical",
                {
                    win = "input",
                    height = 1,
                    border = "solid",
                    title = "{title} {live} {flags}",
                },
                {
                    win = "list",
                    border = "solid",
                },
            },
        },
    }
}

M.all = {
    hidden = true,
    ignored = true,
    follow = true,
}

local preview = {
    layout = {
        preview = true,
        height = 0.85,
        row = 0.05,
    }
}

M.vscode_preview = vim.tbl_deep_extend("force", M.vscode, preview)
M.vscode_all = vim.tbl_deep_extend("force", M.vscode, M.all)

M.vscode_preview_all = vim.tbl_deep_extend("force", M.vscode_preview, M.vscode_all)

M.wide = {
    layout = {
        box = "horizontal",
        min_width = 120,
        width = 0.85,
        height = 0.85,
        backdrop = false,
        {
            box = "vertical",
            {
                win = "input",
                height = 1,
                border = "solid",
                title = "{title} {live} {flags}",
            },
            { win = "list", border = "solid" },
        },
        {
            win = "preview",
            title = "{preview}",
            border = "solid",
            width = 0.55
        },
    }
}

M.narrow = {
    layout = {
        box = "vertical",
        width = 0.9,
        height = 0.9,
        backdrop = false,
        {
            win = "preview",
            title = "{preview}",
            height = 0.65,
            border = "solid",
        },
        {
            box = "vertical",
            {
                win = "input",
                height = 1,
                border = "solid",
                title = "{title} {live} {flags}",
            },
            {
                win = "list",
                border = "solid",
            },
        },
    }
}

M.git_wide = {
    layout = {
        box = "horizontal",
        min_width = 120,
        width = 0.85,
        height = 0.85,
        backdrop = false,
        {
            box = "vertical",
            {
                win = "input",
                height = 1,
                border = "solid",
                title = "{title} {live} {flags}",
            },
            { win = "list", border = "solid" },
        },
        {
            win = "preview",
            title = "{preview}",
            border = "solid",
            width = 0.6
        },
    }
}

M.adaptive_width = function(wide, narrow)
    return function()
        return vim.o.columns >= 120 and wide or narrow
    end
end

return M
