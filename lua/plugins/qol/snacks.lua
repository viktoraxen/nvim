-- A collection of small QoL plugins for Neovim.
local all = {
    hidden = true,
    ignored = true,
    follow = true,
}

local vscode = {
    layout = {
        preset = "vscode"
    }
}

return {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    -- event = 'VeryLazy',
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
        terminal = require 'plugins.qol.snacks.terminal',
        words = { enabled = true },
        styles = require 'plugins.qol.snacks.styles',
    },
    keys = {
        { "grc",        function() Snacks.picker.lsp_declarations() end,      desc = "Go to declaration" },
        { "grd",        function() Snacks.picker.lsp_definitions() end,       desc = "Go to definition" },
        { "gri",        function() Snacks.picker.lsp_implementations() end,   desc = "Implementation" },
        { "grr",        function() Snacks.picker.lsp_references() end,        desc = "References" },
        { "grt",        function() Snacks.picker.lsp_type_definitions() end,  desc = "Go to type definition" },

        { "<leader>lc", function() Snacks.picker.lsp_declarations() end,      desc = "Declarations" },
        { "<leader>ld", function() Snacks.picker.lsp_definitions() end,       desc = "Definitions" },
        { "<leader>li", function() Snacks.picker.lsp_implementations() end,   desc = "Implementation" },
        { "<leader>lr", function() Snacks.picker.lsp_references() end,        desc = "References" },
        { "<leader>lt", function() Snacks.picker.lsp_type_definitions() end,  desc = "Type definitions" },

        { "<leader>f",  function() Snacks.picker.files(vscode) end,           desc = "Search files" },
        { "<leader>F",  function() Snacks.picker.files(all) end,              desc = "Search files" },
        { "<leader>ss", function() Snacks.picker.grep() end,                  desc = "String" },
        { "<leader>sS", function() Snacks.picker.grep(all) end,               desc = "String" },
        { "<leader>sg", function() Snacks.picker.git_files() end,             desc = "Git files" },
        { "<leader>sG", function() Snacks.picker.git_files(all) end,          desc = "Git files" },
        { "<leader>sd", function() Snacks.picker.diagnostics() end,           desc = "Diagnostics" },
        { "<leader>sf", function() Snacks.picker.files() end,                 desc = "Files" },
        { "<leader>sh", function() Snacks.picker.highlights() end,            desc = "Highlights" },
        { "<leader>si", function() Snacks.picker.icons() end,                 desc = "Icons" },
        { "<leader>sp", function() Snacks.picker.projects() end,              desc = "Projects" },
        { "<leader>sP", function() Snacks.picker.pickers() end,               desc = "Pickers" },
        { "<leader>sr", function() Snacks.picker.resume() end,                desc = "Resume previous" },
        { "<leader>sl", function() Snacks.picker.lsp_symbols() end,           desc = "Symbols" },
        { "<leader>sw", function() Snacks.picker.lsp_workspace_symbols() end, desc = "Workspace symbols" },

        { "<M-3>",      function() Snacks.terminal() end,                     desc = "Toggle terminal",      mode = { "n", "i", "v", "t" } },
        { "<leader>t",  function() Snacks.terminal() end,                     desc = "Toggle terminal",      mode = { "n" } },

        { "<leader>gg", function() Snacks.lazygit() end,                      desc = "Lazygit" },
    },

    init = require 'plugins.qol.snacks.initsnacks',

}
