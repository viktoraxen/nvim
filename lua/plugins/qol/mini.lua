return {
    { -- Collection of various small independent plugins/modules
        'echasnovski/mini.nvim',
        version = '*',
        config = function()
            require('mini.ai').setup { n_lines = 500 }
            require('mini.move').setup {}
            require('mini.align').setup {}
        end,
    },
}
