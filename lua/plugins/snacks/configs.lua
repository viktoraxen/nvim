local layouts = require('plugins.snacks.layouts')

local M = {}

M.git_status = {
    layout = layouts.adaptive_width(layouts.git_wide, layouts.narrow),
    win = {
        input = {
            keys = {
                ["<c-l>"] = { "git_stage", mode = { "n", "i" } },
                ["<C-i"] = { "git_restore", mode = { "n", "i" } },
            }
        }
    }
}

return M
