return {
    'saghen/blink.cmp',
    enabled = true,
    dependencies = { 'rafamadriz/friendly-snippets' },
    version = '1.*',
    opts_extend = { "sources.default" },
    config = function()
        vim.api.nvim_create_autocmd("User", {
            pattern = "BlinkCmpMenuOpen",
            callback = function()
                vim.g.snacks_animate = false
            end
        })

        vim.api.nvim_create_autocmd("User", {
            pattern = "BlinkCmpMenuClose",
            callback = function()
                vim.g.snacks_animate = true
            end
        })

        require('blink.cmp').setup(
        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
            {
                keymap = {
                    preset = 'default',
                    ['<c-h>'] = { 'cancel' },
                    ['<c-j>'] = { 'select_next' },
                    ['<c-k>'] = { 'select_prev' },
                    ['<c-l>'] = { 'select_and_accept' },
                    ['<c-o>'] = { 'show_documentation' },
                    ['<c-d>'] = { 'scroll_documentation_down' },
                    ['<c-u>'] = { 'scroll_documentation_up' },
                },

                completion = {
                    documentation = {
                        auto_show = false,
                        window = {
                            border = 'solid',
                            winblend = 5,
                        }
                    },
                    menu = {
                        winblend = 5,
                        border = 'none'
                    },
                },

                signature = { window = { border = 'none' } },

                sources = {
                    default = { 'lsp', 'path', 'snippets', 'buffer' },
                },
            })
    end
}
