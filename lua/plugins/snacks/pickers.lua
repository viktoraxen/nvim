local layouts = require("plugins.snacks.layouts")
local uv = vim.uv or vim.loop

local M = {}

M.gitter = function()
    Snacks.picker({
        source = "git_status",
        title = "Gitter",
        layout = layouts.adaptive_width(layouts.git_wide, layouts.narrow),
        format = function(item, _)
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
        end,
        actions = {
            restore = function(picker)
                local item = picker:selected({ fallback = true })[1]

                local msg = ("Discard changes to %s?"):format(item.file)

                Snacks.input.input(
                    {
                        prompt = msg,
                        icon = "(y/n):",
                        win = {
                            relative = "editor",
                            row = 0.4,
                            col = 0.38,
                        }
                    },
                    function(input)
                        if input ~= "y" then return end

                        local cmd = { "git", "restore", item.file }

                        Snacks.picker.util.cmd(cmd, function(_, _)
                            vim.schedule(function()
                                picker.list:set_selected()
                                picker.list:set_target()
                                picker:find()
                                vim.cmd.startinsert()
                            end)
                        end, { cwd = item.cwd })
                    end
                )
            end,
            commit = function(picker)
                Snacks.input.input(
                    {
                        prompt = "Commit message",
                        win = {
                            relative = "editor",
                            width = 0.5,
                            row = 0.4,
                            col = 0.25,
                        }
                    },

                    function(input)
                        local cmd = { "git", "commit", "-m", input }

                        Snacks.picker.util.cmd(
                            cmd,
                            function(output, code)
                                if code ~= 0 then
                                    Snacks.notify.error(
                                        ("Commit failed! \n%s"):format(
                                            vim.trim(table.concat(output, ""))
                                        )
                                    )
                                else
                                    Snacks.notify.info("Commited!")

                                    picker:find({
                                        on_done = function()
                                            if #picker:items() == 0 then
                                                picker:close()
                                            end
                                        end
                                    })
                                end
                            end,
                            { cwd = picker:cwd() }
                        )
                    end
                )
            end,
        },
        win = {
            input = {
                keys = {
                    ["<c-l>"] = { "git_stage", mode = { "n", "i" } },
                    ["<c-x>"] = { "restore", mode = { "n", "i" } },
                    ["<c- >"] = { "commit", mode = { "n", "i" } },
                }
            },
            preview = {
                wo = {
                    wrap = false
                }
            }
        },
    })
end
return M
