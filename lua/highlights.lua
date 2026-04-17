local hl = require("highlight-utils")

vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    hl.set({
      LineNr = { bg = "NONE", update = true },
      CursorLineNr = { bg = "NONE", update = true },
      StatusLine = { bg = "NONE", update = true },
      StatusLineNC = { bg = "NONE", update = true },
      SignColumn = { bg = "NONE", update = true },
      Fold = { bg = "NONE", update = true },

      TabLine = { fg = hl.get("Comment", "fg"), bg = "NONE", update = true },
      TabLineSel = { bg = "NONE", update = true },

      NormalFloat = { bg = hl.lighten("Normal", 0.98), update = true },
      FloatBorder = { bg = hl.lighten("Normal", 0.98), update = true },
      FloatTitle = { bg = hl.lighten("Normal", 0.98), update = true },

      PMenuExtra = { bg = "NONE", update = true },

      LightFloat = { bg = hl.lighten("Normal", 0.96) },
      LightFloatTitle = { fg = hl.get("FloatTitle", "fg"), bg = hl.lighten("Normal", 0.96) },
      DarkFloat = { bg = hl.darken("Normal", 0.95) },
      DarkFloatTitle = { fg = hl.get("FloatTitle", "fg"), bg = hl.darken("Normal", 0.95) },

      FadeStart = { bg = "#7F6A9B" },

      WhichKeyGroup = { fg = hl.get("KeyWord", "fg") },
      WhichKeySeparator = { fg = hl.get("Comment", "fg") },
    })

    hl.link({
      DiagnosticSignInfo = "DiagnosticInfo",
      DiagnosticSignTrace = "DiagnosticTrace",
      DiagnosticSignDebug = "DiagnosticDebug",
      DiagnosticSignWarn = "DiagnosticWarn",
      DiagnosticSignError = "DiagnosticError",

      MsgSeparator = "WinSeparator",

      NeogitNormalFloat = "LightFloat",

      PMenu = "LightFloat",

      SnacksPickerInput = "LightFloat",
      SnacksPickerInputBorder = "SnacksPickerInput",
      SnacksPickerInputLine = "SnacksPickerInput",
      SnacksPickerInputFooter = "SnacksPickerInput",
      SnacksPickerInputSearch = "SnacksPickerInput",
      SnacksPickerInputCursorLine = "SnacksPickerInput",
      SnacksPickerInputTitle = "LightFloatTitle",

      SnacksInputNormal = "LightFloat",
      SnacksInputIcon = "SnacksInputNormal",
      SnacksInputBorder = "SnacksInputNormal",
      SnacksInputTitle = "SnacksInputNormal",
      SnacksInputCursorLine = "SnacksInputNormal",

      SnacksPickerToggle = "SnacksPickerInputTitle",
      SnacksPickerPrompt = "SnacksPickerInputTitle",

      SnacksPickerPreview = "DarkFloat",
      SnacksPickerPreviewBorder = "SnacksPickerPreview",
      SnacksPickerPreviewFooter = "SnacksPickerPreview",
      SnacksPickerPreviewNormal = "SnacksPickerPreview",
      SnacksPickerPreviewTitle = "DarkFloatTitle",

      SnacksPickerListBorder = "SnacksPickerList",
      SnacksPickerListCursorLine = "PMenuSel",

      SnacksNotifierBorderTrace = "NormalFloat",
      SnacksNotifierTrace = "NormalFloat",
      SnacksNotifierBorderInfo = "NormalFloat",
      SnacksNotifierInfo = "NormalFloat",
      SnacksNotifierBorderWarn = "NormalFloat",
      SnacksNotifierWarn = "NormalFloat",
      SnacksNotifierBorderDebug = "NormalFloat",
      SnacksNotifierDebug = "NormalFloat",
      SnacksNotifierBorderError = "NormalFloat",
      SnacksNotifierError = "NormalFloat",

      TinyCmdlineNormal = "DarkFloat",
      TinyCmdlineBorder = "TinyCmdlineNormal",

      WindowPickerStatusLineNC = "DiagnosticOk",
      WindowPickerStatusLine = "DiagnosticError",
      WindowPickerWinbarNC = "DiagnosticOk",
      WindowPickerWinbar = "DiagnosticError",

      ["@markup.heading.1.delimiter.vimdoc"] = "@markup.heading",
      ["@markup.heading.2.delimiter.vimdoc"] = "@markup.heading",
    })
  end,
})
