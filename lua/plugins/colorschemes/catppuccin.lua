return {
    'catppuccin/nvim',
    priority = 1000,
    config = function()
        require('catppuccin').setup {
            dim_inactive = {
                enabled = true,
                shade = 'dark',
                percentage = 0.1,
            },
        }
        vim.cmd [[colorscheme catppuccin-macchiato]]
    end,
}
