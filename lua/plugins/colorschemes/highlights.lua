return {
  "highlights-nvim",
  dev = true,
  event = "VeryLazy",
  config = function()
    local no_italic = { italic = false, cterm = { italic = false } }
    local no_underline = { underline = false, cterm = { underline = false } }

    local globals = {}

    for _, level in ipairs({ "Ok", "Debug", "Hint", "Info", "Warn", "Error", "Unnecessary" }) do
      globals["Diagnostic" .. level] = no_italic
    end

    for _, group in ipairs({
      "DiagnosticUnderlineOk",
      "DiagnosticUnderlineHint",
      "DiagnosticUnderlineInfo",
      "DiagnosticUnderlineWarn",
      "DiagnosticUnderlineError",
      "LspDiagnosticsUnderlineHint",
      "LspDiagnosticsUnderlineError",
      "LspDiagnosticsUnderlineWarning",
      "LspDiagnosticsUnderlineInformation",
    }) do
      globals[group] = no_underline
    end

    globals.CursorLine = { bg = "Normal" }
    globals.LineNr = { bg = false }
    globals.SignColumn = { bg = false }
    globals.EndOfBuffer = { fg = "Normal", bg = false }

    globals.NormalFloat = { bg = "Normal|Folded" }
    globals.FloatTitle = { fg = "Title", bg = "Normal|Folded" }
    globals.LightFloat = { bg = "Folded" }
    globals.LightFloatTitle = { fg = "Title", bg = "Folded" }
    globals.DarkFloat = { bg = "Normal|contrast|0.8" }
    globals.DarkFloatTitle = { fg = "Title", bg = "Normal|contrast|0.8" }

    require("highlights-nvim").add({
      customizations = {
        ["*"] = globals,
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
