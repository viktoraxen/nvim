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

    local actual_filetypes = function()
      for _, ft in ipairs(disabled_fts) do
        if string.match(vim.bo.ft, ft) then
          return false
        end
      end

      return true
    end

    local filepath = function()
      local full_filepath = vim.fn.expand("%:p")

      if full_filepath == "" or full_filepath:match("^%[%a%s*%a+%]$") or full_filepath:match("term://.*") then
        return ""
      end

      local relative_to_cwd_filepath = vim.fn.fnamemodify(full_filepath, ":.")

      local dir_path = vim.fn.fnamemodify(relative_to_cwd_filepath, ":h")

      if dir_path == "." or dir_path == "" then
        return ""
      end

      dir_path = dir_path:gsub("/$", "")

      return " " .. dir_path
    end

    local venv = function()
      local devicons = require("nvim-web-devicons")
      local icon, group = devicons.get_icon_by_filetype("python", { default = true })
      local venv_name = ""

      local virtual_env_path = os.getenv("VIRTUAL_ENV")
      if virtual_env_path then
        local sep = package.config:sub(1, 1)
        local parts = {}
        for part in string.gmatch(virtual_env_path, "[^" .. sep .. "]+") do
          table.insert(parts, part)
        end
        if #parts > 0 then
          venv_name = parts[#parts]
        end
      else
        local conda_env = os.getenv("CONDA_DEFAULT_ENV")
        if conda_env then
          venv_name = conda_env
        end
      end

      if venv_name ~= "" then
        return venv_name
      end

      return ""
    end

    require("lualine").setup({
      options = {
        icons_enabled = true,
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = {
          statusline = disabled_fts,
          winbar = disabled_fts,
        },
        ignore_focus = {},
        always_divide_middle = true,
        always_show_tabline = true,
        globalstatus = true,
        refresh = {
          statusline = 1000,
          tabline = 1000,
          winbar = 1000,
          refresh_time = 16, -- ~60fps
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
              local first_char = string.sub(str, 1, 1)
              local rest_of_string_lower = string.lower(string.sub(str, 2))

              return first_char .. rest_of_string_lower
            end,
          },
        },
        lualine_b = {
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
        lualine_c = {},
        lualine_x = {
          { "branch", icon = "" },
          { venv, icon = "󰹩" },
        },
        lualine_y = {
          "searchcount",
          { "filetype", cond = actual_filetypes, color = { bg = vim.NIL } },
        },
        lualine_z = {
          { "progress", padding = { left = 1, right = 0 } },
          { "location", padding = { left = 1, right = 1 } },
        },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {
          {
            "filename",
            file_status = false,
            icon = "󰧮",
            cond = actual_filetypes,
          },
        },
        lualine_c = { { filepath } },
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
      },
      winbar = {
        lualine_b = {
          {
            "filename",
            file_status = false,
            icon = "󰧮",
            cond = actual_filetypes,
          },
        },
        lualine_c = { { filepath } },
      },
      inactive_winbar = {
        lualine_b = {
          {
            "filename",
            file_status = false,
            icon = "󰧮",
            cond = actual_filetypes,
          },
        },
        lualine_c = { { filepath } },
      },
    })

    local highlights_utils = require("highlights-nvim.utils")

    local modes = {
      "normal",
      "visual",
      "insert",
      "command",
      "terminal",
      "replace",
      "inactive",
    }

    local sections = {
      "a",
      "b",
      "c",
    }

    local diagnostics = {
      "error",
      "hint",
      "warn",
      "info",
    }

    local apply_highlights = function()
      -- Invert lualine_a
      for _, mode in ipairs(modes) do
        local current_a_hl = highlights_utils.get_hl("lualine_a_" .. mode)
        local new_fg = nil

        if current_a_hl.bg then
          new_fg = string.format("#%06x", current_a_hl.bg)
        end

        local new_a_hl = vim.tbl_deep_extend("force", current_a_hl, { fg = new_fg })

        local normal_hl = highlights_utils.get_hl("Normal")
        local current_b_hl = highlights_utils.get_hl("lualine_b_" .. mode)
        local normal_fg = string.format("#%06x", normal_hl.fg)
        local new_b_hl = vim.tbl_deep_extend("force", current_b_hl, { fg = normal_fg })

        vim.api.nvim_set_hl(0, "lualine_a_" .. mode, new_a_hl)
        vim.api.nvim_set_hl(0, "lualine_b_" .. mode, new_b_hl)
      end

      -- Remove background from all
      local all_hls = vim.api.nvim_get_hl(0, {})

      for group_name, hl in pairs(all_hls) do
        if group_name:match("^lualine") then
          hl.bg = nil
          vim.api.nvim_set_hl(0, group_name, hl)
        end
      end

      require("highlights-nvim").add({
        links = {
          lualine_b_inactive = "lualine_b_normal",
          lualine_c_normal = "lualine_c_inactive",
          WinBar = "lualine_b_normal",
          WinBarNC = "WinBar",
        },
      })
    end

    apply_highlights()
  end,
}
