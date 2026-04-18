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

local hl = require("highlight-utils")

hl.set({
  SnacksPickerTotals = { bg = "NONE", update = true },
})

hl.link({
  SnacksPickerInput = "LightFloat",
  SnacksPickerInputBorder = "SnacksPickerInput",
  SnacksPickerInputLine = "SnacksPickerInput",
  SnacksPickerInputFooter = "SnacksPickerInput",
  SnacksPickerInputSearch = "SnacksPickerInput",
  SnacksPickerInputCursorLine = "SnacksPickerInput",
  SnacksPickerInputTitle = "LightFloatTitle",

  SnacksInputNormal = "LightFloat",
  SnacksInputBorder = "SnacksInputNormal",
  SnacksInputCursorLine = "SnacksInputNormal",
  SnacksInputTitle = "LightFloatTitle",
  SnacksInputIcon = "SnacksInputTitle",

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
