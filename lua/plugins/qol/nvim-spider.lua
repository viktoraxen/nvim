return {
    'chrisgrieser/nvim-spider',
    event = 'VimEnter',
    config = function()
        local map = require('utils.keymap')

        map.n('e', "<cmd>lua require('spider').motion('e')<cr>", 'End of word')
        map.v('e', "<cmd>lua require('spider').motion('e')<cr>", 'End of word')
        map.o('e', "<cmd>lua require('spider').motion('e')<cr>", 'End of word')

        map.n('w', "<cmd>lua require('spider').motion('w')<cr>", 'Start of next word')
        map.v('w', "<cmd>lua require('spider').motion('w')<cr>", 'Start of next word')
        map.o('w', "<cmd>lua require('spider').motion('w')<cr>", 'Start of next word')

        map.n('b', "<cmd>lua require('spider').motion('b')<cr>", 'Start of previous word')
        map.v('b', "<cmd>lua require('spider').motion('b')<cr>", 'Start of previous word')
        map.o('b', "<cmd>lua require('spider').motion('b')<cr>", 'Start of previous word')

        map.n('E', 'e', 'End of word')
        map.v('E', 'e', 'End of word')
        map.n('W', 'w', 'Start of next word')
        map.v('W', 'w', 'Start of next word')
        map.n('B', 'b', 'Start of previous word')
        map.v('B', 'b', 'Start of previous word')
    end,
}
