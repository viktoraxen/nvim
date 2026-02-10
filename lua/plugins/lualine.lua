return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VeryLazy",
  config = function()
    local disabled_fts = {
      "neo%-tree",
      "snacks",
      "sidekick",
      "alpha",
      "tmux",
    }

    local function is_enabled_ft()
      for _, ft in ipairs(disabled_fts) do
        if vim.bo.ft:match(ft) then
          return false
        end
      end
      return true
    end

    local function filepath()
      local full = vim.fn.expand("%:p")
      if full == "" or full:match("^%[%a%s*%a+%]$") or full:match("term://") then
        return ""
      end

      local dir = vim.fn.fnamemodify(vim.fn.fnamemodify(full, ":."), ":h")
      if dir == "." or dir == "" then
        return ""
      end

      return " " .. dir:gsub("/$", "")
    end

    local function venv()
      local env = os.getenv("VIRTUAL_ENV")
      if env then
        local sep = package.config:sub(1, 1)
        return env:match("[^" .. sep .. "]+$") or ""
      end
      return os.getenv("CONDA_DEFAULT_ENV") or ""
    end

    local function git_file_status()
      local file = vim.fn.expand("%:p")
      if file == "" or file:match("term://") then
        return "" -- non-file buffer
      end

      local output = vim.fn.system({ "git", "status", "--porcelain", "--", file })
      if vim.v.shell_error ~= 0 then
        return "" -- not a git repo
      end

      output = output:gsub("%s+$", "")
      if output == "" then
        return " " -- committed
      end

      local x, y = output:sub(1, 1), output:sub(2, 2)

      if x == "?" then
        return " " -- untracked
      end
      if x == "!" then
        return " " -- ignored
      end
      if x == "U" or y == "U" then
        return " " -- conflict
      end

      local staged_icons = { A = " ", M = "󰜥 ", D = " ", R = "󰳞 " }
      local staged = staged_icons[x]
      local unstaged = (y == "M" or y == "D") and "" or nil

      if staged and unstaged then
        return staged .. " " .. unstaged -- staged + unstaged
      end
      if staged then
        return staged -- staged
      end
      if unstaged then
        return unstaged -- unstaged
      end

      return "" -- unknown
    end

    local filename_component = {
      "filename",
      file_status = true,
      symbols = { modified = " ●", readonly = " 󰌾" },
      icon = "󰧮",
      cond = is_enabled_ft,
    }

    local filepath_component = { filepath }

    require("lualine").setup({
      options = {
        icons_enabled = true,
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = { statusline = disabled_fts, winbar = disabled_fts },
        ignore_focus = {},
        always_divide_middle = true,
        always_show_tabline = true,
        globalstatus = true,
        refresh = {
          statusline = 1000,
          tabline = 1000,
          winbar = 1000,
          refresh_time = 16,
          events = {
            "WinEnter",
            "BufEnter",
            "BufWritePost",
            "SessionLoadPost",
            "FileChangedShellPost",
            "VimResized",
            "Filetype",
            "CursorMoved",
            "CursorMovedI",
            "ModeChanged",
          },
        },
      },
      sections = {
        lualine_a = {
          {
            "mode",
            fmt = function(str)
              return str:sub(1, 1) .. str:sub(2):lower()
            end,
          },
        },
        lualine_b = {
          -- { git_file_status, cond = is_enabled_ft },
        },
        lualine_c = {
          {
            "diagnostics",
            padding = { left = 0, right = 1 },
            symbols = {
              error = " ",
              warn = " ",
              info = " ",
              hint = " ",
            },
            update_in_insert = true,
          },
        },
        lualine_x = {
          {
            function()
              return ""
            end,
            cond = function()
              return package.loaded["copilot"] ~= nil
            end,
          },
          { "branch", icon = "" },
          { venv, icon = "󰹩" },
        },
        lualine_y = {
          "searchcount",
          { "filetype", cond = is_enabled_ft, color = { bg = vim.NIL } },
        },
        lualine_z = {
          { "progress", padding = { left = 1, right = 0 } },
          { "location", padding = { left = 1, right = 1 } },
        },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = { filename_component },
        lualine_c = { filepath_component },
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
      },
      winbar = {
        lualine_b = { filename_component },
        lualine_c = { filepath_component },
      },
      inactive_winbar = {
        lualine_b = { filename_component },
        lualine_c = { filepath_component },
      },
    })

    -- Highlight overrides: flat statusline with mode-colored A/Z sections
    local get_hl = require("highlights-nvim.utils").get_hl
    local modes = { "normal", "visual", "insert", "command", "terminal", "replace", "inactive" }

    local section_styles = {
      { prefixes = { "lualine_a_", "lualine_z_" }, fg = "mode", bold = true },
      { prefixes = { "lualine_b_", "lualine_y_" }, fg = "normal" },
      { prefixes = { "lualine_c_", "lualine_x_" }, fg = "conceal" },
    }

    local function hex(val)
      return val and string.format("#%06x", val) or nil
    end

    local function apply_highlights()
      local normal_fg = hex(get_hl("Normal").fg)
      local conceal_fg = hex(get_hl("Conceal").fg)
      local set_groups = {}

      for _, mode in ipairs(modes) do
        local mode_color = hex(get_hl("lualine_a_" .. mode).bg)
        local colors = { mode = mode_color, normal = normal_fg, conceal = conceal_fg }

        for _, style in ipairs(section_styles) do
          for _, prefix in ipairs(style.prefixes) do
            local group = prefix .. mode
            vim.api.nvim_set_hl(0, group, { fg = colors[style.fg], bold = style.bold })
            set_groups[group] = true
          end
        end
      end

      for name, hl in pairs(vim.api.nvim_get_hl(0, {})) do
        if name:match("^lualine") and not set_groups[name] then
          hl.bg = nil
          vim.api.nvim_set_hl(0, name, hl)
        end
      end

      require("highlights-nvim").add({
        links = {
          ["*"] = {
            StatusLine = "Normal",
            lualine_b_inactive = "lualine_b_normal",
            lualine_c_normal = "lualine_c_inactive",
            WinBar = "lualine_b_normal",
            WinBarNC = "WinBar",
          },
        },
      })
    end

    apply_highlights()

    vim.api.nvim_create_autocmd("ColorScheme", {
      callback = function()
        vim.schedule(apply_highlights)
      end,
    })
  end,
}
