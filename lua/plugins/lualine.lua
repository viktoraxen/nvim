return {
    'nvim-lualine/lualine.nvim',
    event = "VimEnter",
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
                lualine_a = {
                    {
                        "mode", separator = { left = "", right = "" },
                        right_padding = 2
                    }
                },
                lualine_c = {
                    {
                        'filename',
                        path = 1,
                        symbols = {
                            modified = '~',
                            readonly = '-',
                        },
                    },
                    'diagnostics',
                },
                lualine_x = { 'copilot' },
                lualine_y = { 'filetype' },
                lualine_z = {
                    {
                        'progress', 'location',
                        separator = { left = "", right = "" },
                        left_padding = 2,
                    }
                },
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
