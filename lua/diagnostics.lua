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
    -- linehl = {
    --   [vim.diagnostic.severity.ERROR] = "ErrorMsg",
    -- },
  },
})

require("highlight-utils").link({
  DiagnosticSignInfo = "DiagnosticInfo",
  DiagnosticSignTrace = "DiagnosticTrace",
  DiagnosticSignDebug = "DiagnosticDebug",
  DiagnosticSignWarn = "DiagnosticWarn",
  DiagnosticSignError = "DiagnosticError",
})
