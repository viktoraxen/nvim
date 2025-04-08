require('lazy').setup({
    { import = 'plugins' },
    { import = 'plugins.colorschemes' },
    { import = 'plugins.copilot' },
    { import = 'plugins.neotree' },
    { import = 'plugins.nvim-cmp' },
    { import = 'plugins.qol' },
    { import = 'plugins.treesitter' },
}, {
    install = {
        colorscheme = { 'catppuccin' },
    },
    ui = {
        border = 'rounded',
        backdrop = 100,
        size = { width = 0.89, height = 0.85 },
    },
})
