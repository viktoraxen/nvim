return {
    'nvim-lualine/lualine.nvim',
    dependencies = {
        'ray-x/lsp_signature.nvim',
    },
    config = function()
        local theme = require('lualine.themes.catppuccin')

        theme.normal.c.bg = vim.fn.synIDattr(vim.fn.hlID("Normal"), "bg")

        require('lualine').setup {
            options = {
                icons_enabled = true,
                theme = theme,
                component_separators = { left = '', right = '' },
                section_separators = { left = '', right = '' },
                disabled_filetypes = {
                    statusline = { 'alpha' },
                    winbar = {},
                },
                ignore_focus = {},
                always_divide_middle = true,
                globalstatus = true,
                refresh = {
                    statusline = 1000,
                    tabline = 1000,
                    winbar = 1000,
                },
            },
            sections = {
                lualine_a = { 'mode' },
                lualine_b = {
                    {
                        'b:gitsigns_head',
                        icon = '',
                    },
                    'diff',
                },
                lualine_c = {
                    {
                        'filename',
                        path = 0,
                        symbols = {
                            modified = '~',
                            readonly = '-',
                        },
                    },
                    'diagnostics',
                },
                lualine_x = { 'copilot' },
                lualine_y = { 'filetype' },
                lualine_z = { 'progress', 'location' },
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { 'filename' },
                lualine_x = { 'location' },
                lualine_y = {},
                lualine_z = {},
            },
            tabline = {},
            winbar = {},
            inactive_winbar = {},
            extensions = {},
        }
    end,
}
