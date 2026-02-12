return {
  "nanozuki/tabby.nvim",
  config = function()
    local theme = {
      fill = "Normal",
      head = "TabLine",
      current_tab = "Normal",
      tab = "TabLine",
      win = "TabLine",
      tail = "TabLine",
    }

    require("highlights-nvim").add({
      customizations = {
        ["*"] = {
          TabLineSel = { bg = "Normal", fg = "DiagnosticHint" },
          TabLine = { bg = "Normal", fg = "Conceal" },
        },
      },
    })

    require("tabby").setup({
      line = function(line)
        return {
          line.spacer(),
          line.tabs().foreach(function(tab)
            local hl = tab.is_current() and theme.current_tab or theme.tab
            return {
              line.sep(" ", hl, theme.fill),
              tab.number(),
              line.sep(" ", hl, theme.fill),
              hl = hl,
              margin = "  ",
            }
          end),
          line.spacer(),
          hl = theme.fill,
        }
      end,
    })
  end,
}
