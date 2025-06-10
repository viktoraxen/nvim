vim.lsp.config['luals'] = {
    cmd = { 'lua-language-server' },
    filetypes = { 'lua' },
    root_markers = { '.luarc.json', '.luarc.jsonc' },
    settings = {
        Lua = {
            runtime = { version = 'LuaJIT' },
            diagnostics = {
                enable = true,
                globals = { 'vim', 'Snacks' },
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
            },
        },
    },
}

vim.lsp.config['clangd'] = {
    cmd = {
        'clangd',
        '--header-insertion=iwyu',
        '--clang-tidy',
        '--log=verbose',
    },
    filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'hpp', 'h' },
    root_markers = { 'build.sh' },
}

vim.lsp.config['pyright'] = {
    cmd = { 'pyright-langserver', '--stdio' },
    filetypes = { 'python' },
    root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", "Pipfile", "pyrightconfig.json", ".git" },
    settings = {
        python = {
            analysis = {
                autoSearchPaths = true,
                typeCheckingMode = 'basic',
                diagnosticMode = 'openFilesOnly',
                useLibraryCodeForTypes = true,
            },
        },
    },
}

vim.lsp.enable 'luals'
vim.lsp.enable 'clangd'
vim.lsp.enable 'pyright'
