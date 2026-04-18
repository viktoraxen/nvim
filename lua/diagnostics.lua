vim.diagnostic.config({
  underline = true,
  update_in_insert = false,
  virtual_text = false,
  severity_sort = true,
  signs = {
    text = {
      [vim.diagnostic.severity.HINT] = "󰌶 ",
      [vim.diagnostic.severity.INFO] = "󰋽 ",
      [vim.diagnostic.severity.WARN] = "󰀪 ",
      [vim.diagnostic.severity.ERROR] = "󰅚 ",
    },
  },
})

-- Keep `signs.text` above so tiny-inline-diagnostic can read the icons, but
-- suppress the built-in signs handler so the signcolumn stays hidden.
vim.diagnostic.handlers.signs = {
  show = function() end,
  hide = function() end,
}

local hl = require("highlight-utils")

hl.set({
  DiagnosticDebug = { italic = false, update = true },
  DiagnosticError = { italic = false, update = true },
  DiagnosticHint = { italic = false, update = true },
  DiagnosticInfo = { italic = false, update = true },
  DiagnosticTrace = { italic = false, update = true },
  DiagnosticWarn = { italic = false, update = true },
})

hl.link({
  DiagnosticSignDebug = "DiagnosticDebug",
  DiagnosticSignError = "DiagnosticError",
  DiagnosticSignHint = "DiagnosticHint",
  DiagnosticSignInfo = "DiagnosticInfo",
  DiagnosticSignTrace = "DiagnosticTrace",
  DiagnosticSignWarn = "DiagnosticWarn",
})
