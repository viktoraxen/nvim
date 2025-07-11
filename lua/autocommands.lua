vim.api.nvim_create_autocmd('WinLeave', {
    desc = 'Deactivate cursorline highight when leaving a window',
    pattern = '*',
    callback = function()
        vim.wo.cursorline = false
    end,
})

vim.api.nvim_create_autocmd('WinEnter', {
    desc = 'Activate cursorline highight when entering a window',
    pattern = '*',
    callback = function()
        vim.wo.cursorline = true
    end,
})

vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

vim.api.nvim_create_autocmd("CursorMoved", {
    desc = "Clear status on cursor move.",
    callback = function()
        vim.cmd("echo ''")
    end,
})

vim.api.nvim_create_autocmd('BufWritePre', {
    desc = 'Format on save',
    callback = function(args)
        local clients = vim.lsp.get_clients { bufnr = args.buf }

        for _, client in ipairs(clients) do
            if client and client:supports_method 'textDocument/formatting' then
                vim.lsp.buf.format { bufnr = args.buf, timeout_ms = 1000 }
                break
            end
        end
    end,
})

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
    callback = function(event)
        local client = vim.lsp.get_client_by_id(event.data.client_id)

        if client and client.server_capabilities.documentHighlightProvider then
            local highlight_augroup = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                desc = 'Highlight word under cursor',
                buffer = event.buf,
                group = highlight_augroup,
                callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
                desc = 'Clear highlight word under cursor on move',
                buffer = event.buf,
                group = highlight_augroup,
                callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
                desc = 'Clear highlight word under cursor on LSP detach',
                group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
                callback = function(event2)
                    vim.lsp.buf.clear_references()
                    vim.api.nvim_clear_autocmds { group = 'lsp-highlight', buffer = event2.buf }
                end,
            })
        end
    end,
})
