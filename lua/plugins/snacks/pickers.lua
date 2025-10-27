local layouts = require("plugins.snacks.layouts")
local formats = require("plugins.snacks.formats")
local actions = require("plugins.snacks.actions")

local M = {}

M.gitter = function()
    Snacks.picker({
        source = "git_status",
        title = "Gitter",
        layout = layouts.adaptive_width(layouts.git_wide, layouts.narrow),
        format = formats.gitter,
        actions = {
            restore = actions.restore,
            commit = actions.commit,
        },
        focus = "list",
        win = {
            input = {
                keys = {
                    ["<c-s>"] = { "git_stage", mode = { "n", "i" } },
                    ["<c-x>"] = { "restore", mode = { "n", "i" } },
                    ["<c- >"] = { "commit", mode = { "n" } },
                    ["<c-j>"] = { "focus_list", mode = { "n", "i" } },
                }
            },
            list = {
                keys = {
                    ["<space>"] = { "git_stage", mode = { "n" } },
                    ["x"] = { "restore", mode = { "n" } },
                    ["C"] = { "commit", mode = { "n" } },
                    ["<c-k>"] = { "focus_input", mode = { "n", "i" } },
                }
            }
        },
    })
end

return M
