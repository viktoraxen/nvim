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
