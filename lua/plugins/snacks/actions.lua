local M = {}

M.restore = function(picker)
    local item = picker:selected({ fallback = true })[1]

    Snacks.input.input(
        {
            prompt = ("Discard changes to %s?"):format(item.file),
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
                    picker.list:set_target()
                    picker:find()
                end)
            end, { cwd = item.cwd })
        end
    )
end

M.commit = function(picker)
    Snacks.input.input(
        {
            prompt = "Commit message",
            win = {
                relative = "editor",
                width = math.floor(vim.o.columns * 0.5),
                row = 0.4,
                col = 0.25,
            }
        },
        function(input)
            local cmd = { "git", "commit", "-m", input }
            local output = {}

            local on_exit = function(_, code)
                local output_str = table.concat(output, "")

                -- TODO: don't show commit failed on <c-c>
                if code ~= 0 then
                    if output_str:match("^.*no changes added to commit.*$") then
                        Snacks.notify.warn("No changes added to commit!")
                    else
                        local error_msg = ("Commit failed! \n%s"):format(vim.trim(output_str))
                        Snacks.notify.error(error_msg)
                    end
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
            end

            vim.fn.jobstart(
                cmd,
                {
                    cwd = picker:cwd(),
                    on_exit = on_exit,
                    on_stdout = function(_, data)
                        output[#output + 1] = table.concat(data, "\n")
                    end,
                }
            )
        end
    )
end

M.stage = function(picker)
    local item = picker:selected({ fallback = true })[1]

    local cmd = item.status:sub(2) == " " and { "git", "restore", "--staged", item.file } or
        { "git", "add", item.file }

    Snacks.picker.util.cmd(cmd, function(_, _)
        picker.list:set_target()
        picker:find()
    end, { cwd = item.cwd })
end

return M
