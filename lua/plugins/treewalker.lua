return {
    'aaronik/treewalker.nvim',
    dependencies = {
        'nvim-treesitter/nvim-treesitter',
    },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local map = require('utils.keymap')

        map.n('<C-M-h>', '<cmd>Treewalker Left<cr>', 'Treewalker Left')
        map.n('<C-M-l>', '<cmd>Treewalker Right<cr>', 'Treewalker Right')
        map.n('<C-M-j>', '<cmd>Treewalker Down<cr>', 'Treewalker Down')
        map.n('<C-M-k>', '<cmd>Treewalker Up<cr>', 'Treewalker Up')

        map.n('<C-S-h>', '<cmd>Treewalker SwapLeft<cr>', 'Treewalker Swap Left')
        map.n('<C-S-l>', '<cmd>Treewalker SwapRight<cr>', 'Treewalker Swap Right')
        map.n('<C-S-j>', '<cmd>Treewalker SwapDown<cr>', 'Treewalker Swap Down')
        map.n('<C-S-k>', '<cmd>Treewalker SwapUp<cr>', 'Treewalker Swap Up')
    end,

    -- The following options are the defaults.
    -- Treewalker aims for sane defaults, so these are each individually optional,
    -- and setup() does not need to be called, so the whole opts block is optional as well.
    opts = {
        -- Whether to briefly highlight the node after jumping to it
        highlight = true,

        -- How long should above highlight last (in ms)
        highlight_duration = 250,

        -- The color of the above highlight. Must be a valid vim highlight group.
        -- (see :h highlight-group for options)
        highlight_group = 'CursorLine',

        -- Whether the plugin adds movements to the jumplist -- true | false | 'left'
        --  true: All movements more than 1 line are added to the jumplist. This is the default,
        --        and is meant to cover most use cases. It's modeled on how { and } natively add
        --        to the jumplist.
        --  false: Treewalker does not add to the jumplist at all
        --  "left": Treewalker only adds :Treewalker Left to the jumplist. This is usually the most
        --          likely one to be confusing, so it has its own mode.
        jumplist = true,
    }
}
