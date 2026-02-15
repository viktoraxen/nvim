return {
  "nanozuki/tabby.nvim",
  config = function()
    local function tab_label(tabid)
      local custom = require("tabby.feature.tab_name").get_raw(tabid)
      if custom ~= "" then
        return custom
      end

      local tabnr = vim.api.nvim_tabpage_get_number(tabid)
      local cwd = vim.fn.getcwd(-1, tabnr)
      local project = vim.fn.fnamemodify(cwd, ":t")

      for _, win in ipairs(vim.api.nvim_tabpage_list_wins(tabid)) do
        local buf = vim.api.nvim_win_get_buf(win)
        local name = vim.api.nvim_buf_get_name(buf)
        if name:match("^codediff://") then
          return "  " .. project
        end
        if vim.bo[buf].filetype == "checkhealth" then
          local lines = vim.api.nvim_buf_get_lines(buf, 0, 20, false)
          for _, line in ipairs(lines) do
            local module = line:match("^(.+) ~$")
            if module then
              return "󰓙  " .. module
            end
          end
          return "󰓙  health"
        end
      end

      return "  " .. project
    end

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
              -- tab.number(),
              tab_label(tab.id),
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
