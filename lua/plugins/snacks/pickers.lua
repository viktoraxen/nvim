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
        win = {
            input = {
                keys = {
                    ["<c-s>"] = { "git_stage", mode = { "n", "i" } },
                    ["<c-x>"] = { "restore", mode = { "n", "i" } },
                    ["<c- >"] = { "commit", mode = { "n", "i" } },
                }
            },
        },
    })
end

return M
