local M = {}

M.restore = function(picker)
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

            vim.fn.jobstart(
                cmd,
                {
                    cwd = picker:cwd(),
                    on_stdout = function(_, data)
                        output[#output + 1] = table.concat(data, "\n")
                    end,
                    on_exit = function(_, code)
                        local output_str = table.concat(output, "")

                        if code ~= 0 then
                            if output_str:match("^.*no changes added to commit.*$") then
                                Snacks.notify.warn("No changes added to commit!")
                            else
                                Snacks.notify.error(
                                    ("Commit failed! \n%s"):format(

                                        vim.trim(output_str)
                                    )
                                )
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
                    end,
                }
            )
        end
    )
end

return M
