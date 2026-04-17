local hl = require("highlight-utils")

hl.set({
  LineNr = { bg = "NONE", update = true },
  CursorLineNr = { bg = "NONE", update = true },
  SignColumn = { bg = "NONE", update = true },
  Fold = { bg = "NONE", update = true },

  TabLine = { fg = hl.fg("Comment"), bg = "NONE", update = true },
  TabLineSel = { bg = "NONE", update = true },
  TabLineFill = { bg = "NONE", update = true },

  NormalFloat = { bg = hl.lighten("Normal", 0.98), update = true },
  FloatBorder = { bg = hl.lighten("Normal", 0.98), update = true },
  FloatTitle = { bg = hl.lighten("Normal", 0.98), update = true },

  PMenuExtra = { bg = "NONE" },

  LightFloat = { bg = hl.lighten("Normal", 0.96) },
  LightFloatTitle = { fg = hl.fg("FloatTitle"), bg = hl.lighten("Normal", 0.96) },
  DarkFloat = { bg = hl.darken("Normal", 0.95) },
  DarkFloatTitle = { fg = hl.fg("FloatTitle"), bg = hl.darken("Normal", 0.95) },

  FadeStart = { bg = "#7F6A9B" },
})

hl.link({
  MsgSeparator = "WinSeparator",

  PMenu = "LightFloat",

  ["@markup.heading.1.delimiter.vimdoc"] = "@markup.heading",
  ["@markup.heading.2.delimiter.vimdoc"] = "@markup.heading",
})
