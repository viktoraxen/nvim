return {
    'catppuccin/nvim',
    priority = 1000,
    config = function()
        require('catppuccin').setup {
            dim_inactive = {
                enabled = false,
                shade = 'dark',
                percentage = 0.1,
            },
        }

        vim.cmd [[colorscheme catppuccin-macchiato]]
    end,
}
