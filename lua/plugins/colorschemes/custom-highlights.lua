return {
    "viktoraxen/custom-highlights-nvim",
    -- "custom-highlights-nvim",
    -- dev = true,
    -- event = "VeryLazy",
    config = function()
        print("Loading highlight")
        require("custom-highlights-nvim").setup({
            customizations = {
                catppuccin = {
                    { 'SnacksPickerPreview',         { bg = "mantle" } },
                    { 'SnacksPickerPreviewBorder',   { bg = "mantle" } },
                    { 'SnacksPickerPreviewFooter',   { bg = "mantle" } },
                    { 'SnacksPickerPreviewNormal',   { bg = "mantle" } },
                    { 'SnacksPickerPreviewTitle',    { bg = "mantle", fg = "sky" } },

                    { 'SnacksPickerInput',           { bg = "surface1" } },
                    { 'SnacksPickerInputBorder',     { bg = "surface1" } },
                    { 'SnacksPickerInputCursorLine', { bg = "surface1" } },
                    { 'SnacksPickerInputFooter',     { bg = "surface1", fg = "red" } },
                    { 'SnacksPickerInputSearch',     { bg = "surface1" } },
                    { 'SnacksPickerInputTitle',      { bg = "surface1", fg = "sky" } },

                    { 'SnacksPickerList',            { bg = "surface0" } },
                    { 'SnacksPickerListBorder',      { bg = "surface0" } },
                    { 'SnacksPickerListFooter',      { bg = "surface0" } },
                    { 'SnacksPickerListTitle',       { bg = "surface0" } },

                    { 'NormalFloat',                 { bg = "surface0", } },
                    { 'PMenu',                       { bg = "surface0", } },
                    { 'PMenuSel',                    { bg = "surface1", } },
                    { 'FloatBorder',                 { bg = "surface0" } },
                    { 'FloatTitle',                  { bg = "surface0", fg = "sky" } },

                    { 'NeoTreeGitUnstaged',          { fg = "subtext0" } },
                    { 'NeoTreeGitModified',          { fg = "subtext0" } },
                    { 'NeoTreeGitAdded',             { fg = "subtext0" } },
                    { 'NeoTreeGitDeleted',           { fg = "subtext0" } },
                    { 'NeoTreeGitUntracked',         { fg = "subtext0" } },

                    { 'SnacksNotifierTitleTrace',    { bg = "surface0", italic = true } },
                    { 'SnacksNotifierTitleDebug',    { bg = "surface0", fg = "sky", italic = true } },
                    { 'SnacksNotifierTitleInfo',     { bg = "surface0", fg = "sky", italic = true } },
                    { 'SnacksNotifierTitleWarn',     { bg = "surface0", fg = "yellow", italic = true } },
                    { 'SnacksNotifierTitleError',    { bg = "surface0", fg = "red", italic = true } },

                    { 'SnacksIndentScope',           { fg = "rosewater" } },

                    { 'LspSignatureActiveParameter', { bg = "overlay0" } },
                },
            },
            links = {
                { src = "NeoTreeFloatNormal",          dst = "NormalFloat" },
                { src = 'NeoTreeFloatBorder',          dst = "FloatBorder" },

                { src = "NeoTreeNormal",               dst = "Normal" },
                { src = "NeoTreeNormalNC",             dst = "NeoTreeNormal" },

                { src = "SnacksPickerBoxBorder",       dst = "FloatBorder" },
                { src = "SnacksPickerPrompt",          dst = "NormalFloat" },
                { src = "SnacksPickerInputCursorLine", dst = "NormalFloat" },

                { src = 'SnacksNotifierBorderTrace',   dst = "NormalFloat" },
                { src = 'SnacksNotifierBorderDebug',   dst = "NormalFloat" },
                { src = 'SnacksNotifierBorderInfo',    dst = "NormalFloat" },
                { src = 'SnacksNotifierBorderWarn',    dst = "NormalFloat" },
                { src = 'SnacksNotifierBorderError',   dst = "NormalFloat" },

                { src = 'SnacksNotifierTrace',         dst = "NormalFloat" },
                { src = 'SnacksNotifierDebug',         dst = "NormalFloat" },
                { src = 'SnacksNotifierInfo',          dst = "NormalFloat" },
                { src = 'SnacksNotifierWarn',          dst = "NormalFloat" },
                { src = 'SnacksNotifierError',         dst = "NormalFloat" },

                { src = 'SnacksInputNormal',           dst = "NormalFloat" },
                { src = 'SnacksInputBorder',           dst = "FloatBorder" },
                { src = 'SnacksInputTitle',            dst = "FloatTitle" },
            },
        })
    end
}
