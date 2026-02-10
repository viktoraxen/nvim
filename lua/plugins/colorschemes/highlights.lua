return {
  -- "viktoraxen/highlights-nvim",
  "highlights-nvim",
  dev = true,
  event = "VeryLazy",
  config = function()
    local highlights = require("highlights-nvim")

    highlights.add({
      customizations = {
        ["*"] = {
          DiagnosticOk = { italic = false, cterm = { italic = false } },
          DiagnosticDebug = { italic = false, cterm = { italic = false } },
          DiagnosticHint = { italic = false, cterm = { italic = false } },
          DiagnosticInfo = { italic = false, cterm = { italic = false } },
          DiagnosticWarn = { italic = false, cterm = { italic = false } },
          DiagnosticError = { italic = false, cterm = { italic = false } },
          DiagnosticUnnecessary = { italic = false, cterm = { italic = false } },

          DiagnosticUnderlineOk = {
            cterm = { underline = false },
            underline = false,
          },
          DiagnosticUnderlineHint = {
            cterm = { underline = false },
            underline = false,
          },
          DiagnosticUnderlineInfo = {
            cterm = { underline = false },
            underline = false,
          },
          DiagnosticUnderlineWarn = {
            cterm = { underline = false },
            underline = false,
          },
          DiagnosticUnderlineError = {
            cterm = { underline = false },
            underline = false,
          },
          LspDiagnosticsUnderlineHint = {
            cterm = { underline = false },
            underline = false,
          },
          LspDiagnosticsUnderlineError = {
            cterm = { underline = false },
            underline = false,
          },
          LspDiagnosticsUnderlineWarning = {
            cterm = { underline = false },
            underline = false,
          },
          LspDiagnosticsUnderlineInformation = {
            cterm = { underline = false },
            underline = false,
          },

          CursorLine = { bg = "Normal" },
          LineNr = { bg = false },
          SignColumn = { bg = false },
          EndOfBuffer = { fg = "Normal", bg = false },

          NormalFloat = { bg = "Normal|Folded" },
          FloatTitle = { fg = "Title", bg = "Normal|Folded" },
          LightFloat = { bg = "Folded" },
          LightFloatTitle = { fg = "Title", bg = "Folded" },
          DarkFloat = { bg = "Normal|contrast|0.8" },
          DarkFloatTitle = { fg = "Title", bg = "Normal|contrast|0.8" },
        },

        catppuccin = {
          Normal = { bg = "mantle" },
          NormalFloat = { bg = "base" },
          FloatTitle = { fg = "sky", bg = "base" },
          LightFloat = { bg = "surface0|base" },
          LightFloatTitle = { fg = "sky", bg = "surface0|base" },
          DarkFloat = { bg = "mantle|crust" },
          DarkFloatTitle = { fg = "sky", bg = "mantle|crust" },
        },
      },
      links = {
        ["*"] = {
          FloatBorder = "NormalFloat",
          PMenu = "NormalFloat",
          PMenuSelect = "LightFloat",

          NormalNC = "Normal",
        },
      },
    })
  end,
}
