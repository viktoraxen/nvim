require('lazy').setup({
    { import = 'plugins' },
    { import = 'plugins.colorschemes' },
    { import = 'plugins.copilot' },
    { import = 'plugins.dap' },
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

local map = require('utils.keymap')

map.n('<leader>il', '<cmd>Lazy<cr>', 'Lazy')
