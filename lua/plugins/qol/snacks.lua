-- A collection of small QoL plugins for Neovim.
return {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
        bigfile = { enabled = true },
        indent = require 'plugins.qol.snacks.indent',
        input = { enabled = true },
        lazygit = require 'plugins.qol.snacks.lazygit',
        notifier = require 'plugins.qol.snacks.notifier',
        picker = require 'plugins.qol.snacks.picker',
        quickfile = { enabled = true },
        scope = { enabled = true },
        scroll = require 'plugins.qol.snacks.scroll',
        -- statuscolumn = { enabled = true },
        terminal = { enabled = true },
        words = { enabled = true },
        styles = require 'plugins.qol.snacks.styles',
    },

    picker = {
        projects = {
            dev = { '~/dev' },
            patterns = { 'CMakeLists.txt' },
        },
    },

    keys = {
        {
            '<leader>gg',
            function()
                Snacks.lazygit()
            end,
            desc = 'Lazygit',
        },
    },

    init = require 'plugins.qol.snacks.initsnacks',
}
