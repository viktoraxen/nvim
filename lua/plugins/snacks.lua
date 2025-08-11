-- A collection of small QoL plugins for Neovim.
local all = {
    hidden = true,
    ignored = true,
    follow = true,
}

local vscode = {
    layout = {
        preset = "vscode",
    }
}

local vscodeall = {
    hidden = true,
    ignored = true,
    follow = true,
    layout = {
        preset = "vscode",
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
        indent = require 'plugins.snacks.indent',
        input = { enabled = true },
        lazygit = require 'plugins.snacks.lazygit',
        notifier = require 'plugins.snacks.notifier',
        picker = require 'plugins.snacks.picker',
        quickfile = { enabled = true },
        scope = { enabled = true },
        scroll = require 'plugins.snacks.scroll',
        -- statuscolumn = { enabled = true },
        terminal = require 'plugins.snacks.terminal',
        words = { enabled = true },
        styles = require 'plugins.snacks.styles',
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
        { "<leader>F",  function() Snacks.picker.files(vscodeall) end,        desc = "Search files (All)" },
        { "<leader>ss", function() Snacks.picker.grep() end,                  desc = "Grep" },
        { "<leader>sS", function() Snacks.picker.grep(all) end,               desc = "Grep (All)" },
        { "<leader>sc", function() Snacks.picker.git_diff() end,              desc = "Git diff" },
        { "<leader>sg", function() Snacks.picker.git_files() end,             desc = "Git files" },
        { "<leader>sG", function() Snacks.picker.git_files(all) end,          desc = "Git files (All)" },
        { "<leader>sd", function() Snacks.picker.diagnostics() end,           desc = "Diagnostics" },
        { "<leader>sD", function() Snacks.picker.diagnostics(all) end,        desc = "Diagnostics (All)" },
        { "<leader>sf", function() Snacks.picker.files() end,                 desc = "Files" },
        { "<leader>sH", function() Snacks.picker.highlights() end,            desc = "Highlights" },
        { "<leader>sh", function() Snacks.picker.help() end,                  desc = "Help" },
        { "<leader>si", function() Snacks.picker.icons(vscode) end,           desc = "Icons" },
        { "<leader>sp", function() Snacks.picker.projects() end,              desc = "Projects" },
        { "<leader>sP", function() Snacks.picker.pickers(vscode) end,         desc = "Pickers" },
        { "<leader>sr", function() Snacks.picker.resume() end,                desc = "Resume" },
        { "<leader>sl", function() Snacks.picker.lsp_symbols() end,           desc = "Symbols" },
        { "<leader>sw", function() Snacks.picker.lsp_workspace_symbols() end, desc = "Workspace symbols" },

        { "<M-3>",      function() Snacks.terminal() end,                     desc = "Toggle terminal",      mode = { "n", "i", "v", "t" } },
        { "<leader>t",  function() Snacks.terminal() end,                     desc = "Toggle terminal",      mode = { "n" } },

        { "<leader>gg", function() Snacks.lazygit() end,                      desc = "Lazygit" },
    },

    init = require 'plugins.snacks.initsnacks',

}
