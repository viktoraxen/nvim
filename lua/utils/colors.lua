local M = {}

local palettes = {
    catppuccin = require("catppuccin.palettes").get_palette()
}

M.get_color = function(palette, name)
    return palettes[palette][name]
end

return M
