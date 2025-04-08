return function()
    -- Save the original notify function
    local original_notify = vim.notify

    vim.notify = function(msg, level, opts)
        if msg and msg:match("Config Change") then
            return
        end

        original_notify(msg, level, opts)
    end

    vim.api.nvim_create_autocmd("User", {
        pattern = "VeryLazy",
        callback = function()
            -- Setup some globals for debugging (lazy-loaded)
            _G.dd = function(...)
                Snacks.debug.inspect(...)
            end
            _G.bt = function()
                Snacks.debug.backtrace()
            end
            vim.print = _G.dd -- Override print to use snacks for `:=` command
        end,
    })
end
