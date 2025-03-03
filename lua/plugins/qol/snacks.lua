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
        -- dashboard = require("plugins.qol.snacks.dashboard"),
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

    keys = {
        {
            '<leader>gg',
            function()
                Snacks.lazygit()
            end,
            desc = 'Lazygit',
        },
        {
            '<leader>f',
            function()
                Snacks.picker.files()
            end,
            desc = 'Search Files',
        },
        {
            '<leader>li',
            function()
                Snacks.picker.lsp_implementations()
            end,
            desc = 'Implementations',
        },
        {
            '<leader>ld',
            function()
                Snacks.picker.lsp_definitions()
            end,
            desc = 'Definitions',
        },
        {
            '<leader>lc',
            function()
                Snacks.picker.lsp_declarations()
            end,
            desc = 'Declarations',
        },
        {
            '<leader>le',
            function()
                Snacks.picker.lsp_references()
            end,
            desc = 'References',
        },
        {
            '<leader>ls',
            function()
                Snacks.picker.lsp_symbols()
            end,
            desc = 'Symbols',
        },
        {
            '<leader>lt',
            function()
                Snacks.picker.lsp_type_definitions()
            end,
            desc = 'Type Definitions',
        },
        {
            '<leader>lw',
            function()
                Snacks.picker.lsp_workspace_symbols()
            end,
            desc = 'Workspace Symbols',
        },
    },

    init = require 'plugins.qol.snacks.initsnacks',
}
