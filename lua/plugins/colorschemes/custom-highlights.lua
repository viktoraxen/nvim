return {
    "viktoraxen/custom-highlights-nvim",
    -- "custom-highlights-nvim",
    -- dev = true,
    event = "VeryLazy",
    config = function()
        local custom_hls = require('custom-highlights-nvim')

        custom_hls.add({
            customizations = {
                catppuccin = {
                    NormalFloat = { bg = "#282938", },
                    FloatTitle = { fg = "#282938", bg = "sky" },
                    LightFloat = { bg = "surface0" },
                    LightFloatTitle = { fg = "surface0", bg = "sky" },
                    DarkFloat = { bg = "mantle" },
                    DarkFloatTitle = { fg = "mantle", bg = "sky" },
                },
            },
            links = {
                FloatBorder = "NormalFloat",
                PMenu = "NormalFloat",
                PMenuSelect = "LightFloat",
            },
        })
    end
}
