local layouts = require("plugins.snacks.layouts")
local uv = vim.uv or vim.loop

local M = {}

local function git(cmd, ...)
    local args, cmd_args = {}, {} ---@type string[], string[]

    for i = 1, select("#", ...) do
        local arg = select(i, ...)
        if type(arg) == "string" then
            cmd_args[#cmd_args + 1] = arg
        else
            vim.list_extend(args, arg.args or {})
            vim.list_extend(cmd_args, arg.cmd_args or {})
        end
    end

    local ret = { "-c", "core.quotepath=false" } ---@type string[]
    vim.list_extend(ret, args)
    ret[#ret + 1] = cmd
    vim.list_extend(ret, cmd_args)
    return ret
end

M.gitter = function()
    Snacks.picker({
        title = "Gitter",
        layout = layouts.adaptive_width(layouts.git_wide, layouts.narrow),
        finder = function(opts, ctx)
            local args = git("status", "-uall", "--porcelain=v1", "-z", { args = { "--no-pager" } }, opts)

            -- Du har 'svim' här, men Neovim standard är 'vim.fs'
            local cwd = vim.fs.normalize(opts and opts.cwd or uv.cwd() or ".") or nil
            cwd = Snacks.git.get_root(cwd)

            local prev ---@type snacks.picker.finder.Item?

            return require("snacks.picker.source.proc").proc({
                opts,
                {
                    sep = "\0",
                    cwd = cwd,
                    cmd = "git",
                    args = args,
                    ---@param item snacks.picker.finder.Item
                    transform = function(item)
                        local status, file = item.text:match("^(..) (.+)$")

                        -- Mappa status-tecken till namn
                        local status_map = {
                            ["M"] = "modified",
                            ["A"] = "added",
                            ["D"] = "deleted",
                            ["R"] = "renamed",
                            ["C"] = "copied",
                            ["U"] = "unmerged",
                            ["?"] = "untracked",
                        }

                        if status then
                            -- 'x' är Index (staged), 'y' är Worktree (unstaged)
                            dd(status)
                            local x = status:sub(1, 1)
                            local y = status:sub(2, 2)

                            item.cwd = cwd
                            item.file = file     -- För rename är detta GAMLA sökvägen
                            item.text = file     -- Använd filnamnet som text för sökning
                            item.status = status -- Spara rå-status (" M")

                            item.git = {
                                status = status_map[x] or status_map[y] or "unknown",
                                staged = x ~= " " and x ~= "?",
                            }

                            prev = item
                        elseif prev and prev.status:find("R") then
                            -- Detta är andra delen av ett namnbyte
                            -- 'item.text' är den NYA sökvägen
                            prev.git.old_file = prev.file -- Spara den gamla sökvägen
                            prev.file = item.text         -- Sätt huvudfilen till den NYA sökvägen
                            prev.text = item.text         -- Sätt visningstexten till den NYA sökvägen
                            return false                  -- Kasta bort denna rad, den är nu en del av 'prev'
                        else
                            return false                  -- Kasta bort andra oväntade rader
                        end
                    end,
                },
            }, ctx)
        end,
        -- Uppdaterad 'format' för att visa status + filnamn
        format = function(item, picker)
            -- local icon = (Snacks.icons.git_status or {})[item.git.status] or item.status
            dd(item.status)
            local icon = item.git.status
            local hl = "SnacksPickerGitStatus" .. (item.git.status:sub(1, 1):upper() .. item.git.status:sub(2))

            local ret = {
                { icon .. " ", hl },
                { item.text,   "SnacksPickerText" }, -- 'item.text' är nu bara filnamnet
            }

            if item.git.old_file then
                table.insert(ret, { "  ", "SnacksPickerComment" })
                table.insert(ret, { item.git.old_file, "SnacksPickerComment" })
            end

            return ret
        end,
        -- Uppdaterad 'confirm' för att öppna den valda filen
        confirm = function(picker, item)
            picker:close()

            if item and item.file then
                vim.cmd("edit " .. item.file)
            end
            -- Om du vill öppna diffen istället:
            -- require("snacks.picker.actions").diff(picker, item)
        end
    })
end
return M
