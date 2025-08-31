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
                    FloatTitle = { bg = "#282938", fg = "sky" },
                    LightFloat = { bg = "surface0" },
                    LightFloatTitle = { bg = "surface0", fg = "sky" },
                    DarkFloat = { bg = "mantle" },
                    DarkFloatTitle = { bg = "mantle", fg = "sky" },
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
