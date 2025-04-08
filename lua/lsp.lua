vim.lsp.config['luals'] = {
    cmd = { 'lua-language-server' },
    filetypes = { 'lua' },
    root_markers = { '.luarc.json', '.luarc.jsonc' },
    settings = {
        Lua = {
            runtime = { version = 'LuaJIT' },
            diagnostics = {
                enable = true,
                globals = { 'vim' },
            },
        },
    },
}

vim.lsp.enable 'luals'

vim.lsp.config['clangd'] = {
    cmd = {
        'clangd',
        '--header-insertion=iwyu',
        '--clang-tidy',
        '--log=verbose'
    },
    filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'hpp', 'h' },
    root_markers = { 'build.sh' },
}

vim.lsp.enable 'clangd'
