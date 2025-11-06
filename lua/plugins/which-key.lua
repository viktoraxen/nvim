return {
    'folke/which-key.nvim',
    event = 'VimEnter',
    config = function()
        require('which-key').setup {
            icons = { rules = false, },
            delay = 500,
        }
    end,
}
