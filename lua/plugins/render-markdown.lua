return {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = {
        'nvim-treesitter/nvim-treesitter',
        'nvim-tree/nvim-web-devicons'
    },
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
        anti_conceal = {
            enabled = false,
            ignore = {
                table_border = true,
            }
        },
        heading = {
            sign = false,
            position = 'inline',
        },
        code = {
            sign = false,
            border = 'thick',
            inline_pad = 1,
            left_pad = 2,
        },
        overrides = {
            buftype = {
                -- LSP Hover window
                nofile = {
                    code = {
                        left_pad = 0,
                        right_pad = 0,
                        disable_background = true,
                        border = 'hide',
                        language = false,
                    },
                }
            }
        }
    },
}
