return {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    branch = 'main',
    build = ':TSUpdate',
    config = function()
        require('nvim-treesitter').install({
            'bash',
            'c',
            'diff',
            'html',
            'javascript',
            'lua',
            'luadoc',
            'markdown',
            'python',
            'vim',
            'vimdoc',
        })
    end
}
