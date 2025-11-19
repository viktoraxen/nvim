return {
    "viktoraxen/highlights-nvim",
    -- "highlights-nvim",
    -- dev = true,
    event = "VeryLazy",
    config = function()
        local highlights = require('highlights-nvim')

        highlights.add({
            customizations = {
                DiagnosticOk = { italic = false, cterm = { italic = false } },
                DiagnosticDebug = { italic = false, cterm = { italic = false } },
                DiagnosticHint = { italic = false, cterm = { italic = false } },
                DiagnosticInfo = { italic = false, cterm = { italic = false } },
                DiagnosticWarn = { italic = false, cterm = { italic = false } },
                DiagnosticError = { italic = false, cterm = { italic = false } },

                catppuccin = {
                    Normal = { bg = "mantle" },

                    NormalFloat = { bg = "base", },
                    FloatTitle = { fg = "sky", bg = "base" },
                    LightFloat = { bg = "surface0|base" },
                    LightFloatTitle = { fg = "sky", bg = "surface0|base" },
                    DarkFloat = { bg = "mantle|crust" },
                    DarkFloatTitle = { fg = "sky", bg = "mantle|crust" },
                },
            },
            links = {
                FloatBorder = "NormalFloat",
                PMenu = "NormalFloat",
                PMenuSelect = "LightFloat",

                NormalNC = "Normal",
            },
        })
    end
}
