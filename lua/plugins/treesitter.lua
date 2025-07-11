return {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = { "VimEnter" },
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
        -- Prefer git instead of curl in order to improve connectivity in some environments
        require('nvim-treesitter.install').prefer_git = true
        ---@diagnostic disable-next-line: missing-fields
        require('nvim-treesitter.configs').setup(opts)
    end,
}
