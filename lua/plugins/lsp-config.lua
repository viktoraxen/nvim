return {
    'neovim/nvim-lspconfig',
    config = function()
        -- vim.lsp.config['typescript'] = {
        --     cmd = { 'typescript-language-server', '--stdio' },
        --     filetypes = { 'typescript', 'typescriptreact' },
        --     root_markers = { 'tsconfig.json' },
        -- }

        -- vim.lsp.config['tailwind'] = {
        --     cmd = { 'tailwindcss-language-server' },
        --     filetypes = {
        --         "html",
        --         "javascript",
        --         "javascriptreact",
        --         "typescript",
        --         "typescriptreact",
        --         "react",
        --     },
        --     root_markers = {
        --         'tsconfig.json'
        --     },
        -- }
        --
        -- vim.lsp.config['tailwind'] = require('nvim-lspconfig.lsp.tailwindcss')
        vim.lsp.config('luals', {})

        vim.lsp.enable 'luals'
        vim.lsp.enable 'clangd'
        vim.lsp.enable 'pyright'
        vim.lsp.enable 'ruff'
        vim.lsp.enable 'typescript'
        vim.lsp.enable 'tailwindcss'
    end
}
