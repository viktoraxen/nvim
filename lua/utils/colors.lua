local M = {}

local palettes = {
  catppuccin = require("catppuccin.palettes").get_palette(),
}

function M.get_color(palette, name)
  return palettes[palette][name]
end

return M
