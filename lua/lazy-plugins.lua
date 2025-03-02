require('lazy').setup({
    { import = 'plugins' },
    { import = 'plugins.colorschemes' },
    { import = 'plugins.lsp' },
    { import = 'plugins.qol' },
}, {
    ui = {
        border = 'single',
        backdrop = false,
    },
})
