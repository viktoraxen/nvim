return {
    "custom-highlights-nvim",
    dev = true,
    event = "VimEnter",
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
            },
        },
        links = {
            { src = "NeoTreeFloatNormal",          dst = "Normal" },
            { src = "NormalFloat",                 dst = "Normal" },
            { src = "ToggleTerm1FloatBorder",      dst = "FloatBorder" },
            { src = "NeoTreeNormal",               dst = "Normal" },
            { src = "NeoTreeNormalNC",             dst = "Normal" },
            { src = "SnacksPickerInputCursorLine", dst = "Normal" },
        }
    }
}
