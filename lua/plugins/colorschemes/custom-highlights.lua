return {
    "viktoraxen/custom-highlights-nvim",
    opts = {
        customizations = {
            catppuccin = {
                { 'FloatBorder',         { fg = "sky" } },
                { 'NeoTreeFloatBorder',  { fg = "sky" } },
                { 'NeoTreeGitUnstaged',  { fg = "subtext0" } },
                { 'NeoTreeGitModified',  { fg = "subtext0" } },
                { 'NeoTreeGitAdded',     { fg = "subtext0" } },
                { 'NeoTreeGitDeleted',   { fg = "subtext0" } },
                { 'NeoTreeGitUntracked', { fg = "subtext0" } },
                { "SlimlineNormal",      { fg = "blue" } },
                { "SlimlineInsert",      { fg = "green" } },
                { "SlimlineVisual",      { fg = "maroon" } },
                { "SlimlineReplace",     { fg = "red" } },
                { "SlimlineCommand",     { fg = "peach" } },
                { "SlimlineOther",       { fg = "green" } },
            },
        },
        links = {
            { src = "NormalFloat",                 dst = "Normal" },
            { src = "FloatBorder",                 dst = "Normal" },
            { src = "ToggleTerm1FloatBorder",      dst = "FloatBorder" },
            { src = "NeoTreeNormal",               dst = "Normal" },
            { src = "NeoTreeNormalNC",             dst = "Normal" },
            { src = "NeoTreeFloatNormal",          dst = "Normal" },
            { src = "SnacksPickerInputCursorLine", dst = "Normal" },
        }
    }
}
