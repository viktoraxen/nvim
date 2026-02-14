return {
  "viktoraxen/highlights-nvim",
  -- "highlights-nvim",
  -- dev = true,
  event = "VeryLazy",
  config = function()
    local no_background = { bg = false }
    local no_italic = { italic = false, cterm = { italic = false } }
    local no_underline = { underline = false, cterm = { underline = false } }

    local globals = {
      LineNr = { bg = false },
      SignColumn = { bg = false },
      EndOfBuffer = { fg = "Normal", bg = false },
      WinSeparator = { bg = false },

      NormalFloat = { bg = "Normal|Folded|0.8" },
      FloatTitle = { fg = "Title", bg = "Normal|Folded|0.8" },
      LightFloat = { bg = "Normal|Folded|0.6" },
      LightFloatTitle = { fg = "Title", bg = "Normal|Folded|0.6" },
      DarkFloat = { bg = "Normal|contrast|0.9" },
      DarkFloatTitle = { fg = "Title", bg = "Normal|contrast|0.9" },
    }

    for _, level in ipairs({ "Ok", "Debug", "Hint", "Info", "Warn", "Error", "Unnecessary" }) do
      globals["Diagnostic" .. level] = no_italic
      globals["DiagnosticSign" .. level] = no_background
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
          NeoTreeCursorLine = "Folded",
          LazyNormal = "DarkFloat",
          MasonNormal = "DarkFloat",
          DapUIFloatNormal = "DarkFloat",
          DapUIFloatBorder = "DarkFloat",
        },
      },
    })
  end,
}
