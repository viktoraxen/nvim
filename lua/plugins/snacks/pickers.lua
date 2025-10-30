local layouts = require("plugins.snacks.layouts")
local formats = require("plugins.snacks.formats")
local actions = require("plugins.snacks.actions")

local M = {}

M.gitter = function()
    Snacks.picker({
        source = "git_status",
        title = "Gitter",
        sort = { fields = { "file", "text" } },
        layout = layouts.adaptive_width(layouts.git_wide, layouts.narrow),
        format = formats.gitter,
        actions = {
            restore = actions.restore,
            commit = actions.commit,
            stage = actions.stage,
        },
        focus = "list",
        win = {
            input = {
                keys = {
                    ["<c-s>"] = { "stage", mode = { "n", "i" } },
                    ["<c-x>"] = { "restore", mode = { "n", "i" } },
                    ["<c- >"] = { "commit", mode = { "n" } },
                    ["<c-j>"] = { "focus_list", mode = { "n", "i" } },
                }
            },
            list = {
                keys = {
                    ["<tab>"] = { "stage", mode = { "n" } },
                    ["<space>"] = { "stage", mode = { "n" } },
                    ["x"] = { "restore", mode = { "n" } },
                    ["C"] = { "commit", mode = { "n" } },
                    ["<c-k>"] = { "focus_input", mode = { "n", "i" } },
                    ['<c-d>'] = { 'preview_scroll_down', mode = { 'i', 'n' } },
                    ['<c-u>'] = { 'preview_scroll_up', mode = { 'i', 'n' } },
                }
            }
        },
    })
end

return M
