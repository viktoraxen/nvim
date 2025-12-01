return {
  "rachartier/tiny-code-action.nvim",
  dependencies = {
    { "nvim-lua/plenary.nvim" },
  },
  event = "LspAttach",
  config = function()
    local codeaction = require("tiny-code-action")
    codeaction.setup({
      backend = "delta",
      picker = {
        "buffer",
        position = "cursor",
        auto_preview = "true",
      },
    })

    local map = require("utils.keymap")

    map.n("gra", codeaction.code_action, "Code actions")
  end,
  opts = {
    backend = "vim",
    picker = "buffer",
    signs = {
      quickfix = { "", { link = "DiagnosticWarning" } },
      others = { "", { link = "DiagnosticWarning" } },
      refactor = { "󰩫", { link = "DiagnosticInfo" } },
      ["refactor.move"] = { "󰪹", { link = "DiagnosticInfo" } },
      ["refactor.extract"] = { "", { link = "DiagnosticError" } },
      ["source.organizeImports"] = { "", { link = "DiagnosticWarning" } },
      ["source.fixAll"] = { "󰃢", { link = "DiagnosticError" } },
      ["source"] = { "", { link = "DiagnosticError" } },
      ["rename"] = { "󰑕", { link = "DiagnosticWarning" } },
      ["codeAction"] = { "", { link = "DiagnosticWarning" } },
    },
  },
}
