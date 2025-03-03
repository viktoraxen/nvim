require('lazy').setup({
    { import = 'plugins' },
    { import = 'plugins.colorschemes' },
    { import = 'plugins.lsp' },
    { import = 'plugins.qol' },
}, {
    install = {
        colorscheme = { 'catppuccin' },
    },
    ui = {
        border = 'double',
        backdrop = 100,
    },
})
