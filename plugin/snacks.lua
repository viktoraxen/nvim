vim.pack.add({
  "https://github.com/folke/snacks.nvim",
  "https://github.com/folke/persistence.nvim",
})

require("snacks").setup({
  bigfile = { enabled = true },
  dashboard = require("config.snacks.dashboard"),
  bufdelete = { enabled = true },
  debug = { enabled = true },
  indent = require("config.snacks.indent"),
  input = require("config.snacks.input"),
  notifier = require("config.snacks.notifier"),
  picker = require("config.snacks.picker"),
  quickfile = { enabled = true },
  rename = { enabled = true },
  scope = { enabled = true },
  scroll = { enabled = true },
  terminal = require("config.snacks.terminal"),
  styles = require("config.snacks.styles"),
})

require("highlight-utils").link({
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
})
