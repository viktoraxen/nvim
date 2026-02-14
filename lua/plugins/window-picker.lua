return {
  "s1n7ax/nvim-window-picker",
  name = "window-picker",
  enabled = true,
  event = "VeryLazy",
  version = "2.*",
  config = function(_, opts)
    require("window-picker").setup(opts)
    require("highlights-nvim").add({
      links = {
        ["*"] = {
          WindowPickerStatusLineNC = "DiagnosticOk",
          WindowPickerStatusLine = "DiagnosticError",
          WindowPickerWinbarNC = "DiagnosticOk",
          WindowPickerWinbar = "DiagnosticError",
        },
      },
    })
  end,
  opts = {
    hint = "statusline-winbar",
    show_prompt = false,
  },
}
