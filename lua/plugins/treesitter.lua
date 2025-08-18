return {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    lazy = false,
    opts = {
        ensure_installed = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'vim', 'vimdoc', 'javascript' },
        auto_install = true,
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = { 'ruby', 'javascript' },
        },
        indent = { enable = true, disable = { 'ruby' } },
    },
    config = function(_, opts)
        require('nvim-treesitter.install').prefer_git = true
        require('nvim-treesitter.configs').setup(opts)
    end,
}
