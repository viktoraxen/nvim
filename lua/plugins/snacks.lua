-- A collection of small QoL plugins for Neovim.
local all = {
    hidden = true,
    ignored = true,
    follow = true,
}

local vscode = {
    layout = {
        preview = false,
        layout = {
            box = "vertical",
            row = 0.25,
            width = 0.5,
            min_width = 75,
            height = 0.4,
            backdrop = false,
            {
                box = "vertical",
                {
                    win = "input",
                    height = 1,
                    border = "solid",
                    title = "{title} {live} {flags}",
                },
                {
                    win = "list",
                    border = "solid",
                },
            },
        }
    }
}

local vscodeall = vim.tbl_deep_extend("force", all, vscode)

return {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
        bigfile = { enabled = true },
        bufdelete = { enabled = true },
        indent = require 'plugins.snacks.indent',
        input = require 'plugins.snacks.input',
        lazygit = require 'plugins.snacks.lazygit',
        notifier = require 'plugins.snacks.notifier',
        picker = require 'plugins.snacks.picker',
        quickfile = { enabled = true },
        rename = { enabled = true },
        scope = { enabled = true },
        scroll = require 'plugins.snacks.scroll',
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
        { "<leader>b",  function() Snacks.picker.buffers(vscode) end,         desc = "Search buffers" },
        { "<leader>sb", function() Snacks.picker.buffers() end,               desc = "Buffers" },
        { "<leader>sd", function() Snacks.picker.diagnostics() end,           desc = "Diagnostics" },
        { "<leader>sD", function() Snacks.picker.diagnostics(all) end,        desc = "Diagnostics (All)" },
        { "<leader>sf", function() Snacks.picker.files() end,                 desc = "Files" },
        { "<leader>sF", function() Snacks.picker.files(all) end,              desc = "Files (All)" },
        { "<leader>sg", function() Snacks.picker.git_files() end,             desc = "Git files" },
        { "<leader>sG", function() Snacks.picker.git_files(all) end,          desc = "Git files (All)" },
        { "<leader>sh", function() Snacks.picker.help() end,                  desc = "Help" },
        { "<leader>sH", function() Snacks.picker.highlights() end,            desc = "Highlights" },
        { "<leader>si", function() Snacks.picker.icons(vscode) end,           desc = "Icons" },
        { "<leader>sl", function() Snacks.picker.lsp_symbols() end,           desc = "Symbols" },
        { "<leader>sp", function() Snacks.picker.projects() end,              desc = "Projects" },
        { "<leader>sP", function() Snacks.picker.pickers(vscode) end,         desc = "Pickers" },
        { "<leader>sr", function() Snacks.picker.resume() end,                desc = "Resume" },
        { "<leader>ss", function() Snacks.picker.grep() end,                  desc = "Grep" },
        { "<leader>sS", function() Snacks.picker.grep(all) end,               desc = "Grep (All)" },
        { "<leader>sw", function() Snacks.picker.lsp_symbols() end,           desc = "Symbols" },
        { "<leader>sW", function() Snacks.picker.lsp_workspace_symbols() end, desc = "Workspace symbols" },

        { "<M-3>",      function() Snacks.terminal() end,                     desc = "Toggle terminal",      mode = { "n", "i", "v", "t" } },
        { "<leader>t",  function() Snacks.terminal() end,                     desc = "Toggle terminal",      mode = { "n" } },
    },
    init = function()
        require('custom-highlights-nvim').add({
            customizations = {
                catppuccin = {
                    SnacksNotifierTitleTrace = { italic = true },
                    SnacksNotifierTitleDebug = { fg = "sky", italic = true },
                    SnacksNotifierTitleInfo = { fg = "sky", italic = true },
                    SnacksNotifierTitleWarn = { fg = "yellow", italic = true },
                    SnacksNotifierTitleError = { fg = "red", italic = true },

                    SnacksIndentScope = { fg = "rosewater" },
                }
            },
            links = {

                SnacksNotifierBorderTrace = "NormalFloat",
                SnacksNotifierBorderDebug = "NormalFloat",
                SnacksNotifierBorderInfo = "NormalFloat",
                SnacksNotifierBorderWarn = "NormalFloat",
                SnacksNotifierBorderError = "NormalFloat",

                SnacksNotifierTrace = "NormalFloat",
                SnacksNotifierDebug = "NormalFloat",
                SnacksNotifierInfo = "NormalFloat",
                SnacksNotifierWarn = "NormalFloat",
                SnacksNotifierError = "NormalFloat",

                SnacksPickerInput = "LightFloat",
                SnacksPickerInputBorder = "SnacksPickerInput",
                SnacksPickerInputLine = "SnacksPickerInput",
                SnacksPickerInputFooter = "SnacksPickerInput",
                SnacksPickerInputSearch = "SnacksPickerInput",
                SnacksPickerInputCursorLine = "SnacksPickerInput",
                SnacksPickerInputTitle = "LightFloatTitle",

                SnacksPickerPrompt = "NormalFloat",

                SnacksPickerPreview = "DarkFloat",
                SnacksPickerPreviewBorder = "SnacksPickerPreview",
                SnacksPickerPreviewFooter = "SnacksPickerPreview",
                SnacksPickerPreviewNormal = "SnacksPickerPreview",
                SnacksPickerPreviewTitle = "DarkFloatTitle",

                SnacksPickerListBorder = "SnacksPickerList",
                SnacksPickerListCursorLine = "LightFloat",

                SnacksInputNormal = "LightFloat",
                SnacksInputBorder = "SnacksInputNormal",
                SnacksInputTitle = "SnacksInputNormal",
                SnacksInputCursorLine = "SnacksInputNormal",
            }
        })

        local original_notify = vim.notify

        vim.notify = function(msg, level, opts)
            if msg and msg:match("Config Change") then
                return
            end

            original_notify(msg, level, opts)
        end

        vim.api.nvim_create_autocmd("User", {
            pattern = "VeryLazy",
            callback = function()
                -- Setup some globals for debugging (lazy-loaded)
                _G.dd = function(...)
                    Snacks.debug.inspect(...)
                end
                _G.bt = function()
                    Snacks.debug.backtrace()
                end
                vim.print = _G.dd -- Override print to use snacks for `:=` command
            end,
        })
    end

}
