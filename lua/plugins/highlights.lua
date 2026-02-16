return {
  -- "viktoraxen/highlights-nvim",
  "highlights-nvim",
  dev = true,
  event = "VeryLazy",
  config = function()
    local no_background = { bg = false }
    local no_italic = { italic = false, cterm = { italic = false } }
    local no_underline = { underline = false, cterm = { underline = false } }

    local globals = {
      LineNr = { bg = false },
      CursorLineNr = { bg = false },
      SignColumn = { bg = false },
      EndOfBuffer = { fg = "Normal", bg = false },
      WinSeparator = { bg = false },

      NormalFloat = { bg = "Normal|highlight|0.98" },
      FloatTitle = { fg = "Title", bg = "NormalFloat" },
      LightFloat = { bg = "Normal|highlight|0.95" },
      LightFloatTitle = { fg = "Title", bg = "LightFloat" },
      DarkFloat = { bg = "Normal|contrast|0.9" },
      DarkFloatTitle = { fg = "Title", bg = "Normal|contrast|0.9" },
    }

    for _, level in ipairs({ "Ok", "Debug", "Hint", "Info", "Warn", "Error", "Unnecessary" }) do
      globals["Diagnostic" .. level] = no_italic
      globals["DiagnosticSign" .. level] = no_background
      globals["DiagnosticVirtualText" .. level] = no_background
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
        yin = {
          WinSeparator = { fg = "Normal|contrast|0.4" },
        },
      },
      links = {
        ["*"] = {
          FloatBorder = "NormalFloat",
          PMenu = "DarkFloat",
          PMenuSelect = "NormalFloat",
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
