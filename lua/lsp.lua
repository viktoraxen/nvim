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
        pyright = { disableOrganizeImports = true },
        python = {
            analysis = {
                ignore = { "*" },
                autoSearchPaths = true,
                typeCheckingMode = 'basic',
                diagnosticMode = 'openFilesOnly',
                useLibraryCodeForTypes = true,
            },
        },
    },
}

vim.lsp.config['ruff_lsp'] = {
    cmd = { 'ruff', 'server', '--preview' },
    filetypes = { 'python' },
    root_markers = { "pyproject.toml", "ruff.toml", ".git" },
    init_options = {
        settings = {
            codeAction = {
                disableRuleComment = { enable = true },
                showDocumentation = { enable = true }
            },
            lint = { enable = true }
        }
    }
}

vim.lsp.enable 'luals'
vim.lsp.enable 'clangd'
vim.lsp.enable 'pyright'
vim.lsp.enable 'ruff_lsp'
