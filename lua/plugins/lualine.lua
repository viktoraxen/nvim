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

    local function actual_filetypes()
      for _, ft in ipairs(disabled_fts) do
        if string.match(vim.bo.ft, ft) then
          return false
        end
      end

      return true
    end

    local function filepath()
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

    local function venv()
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

    local function apply_highlights()
      local normal_fg = highlights_utils.get_hl("Normal").fg
      local conceal_fg = highlights_utils.get_hl("Conceal").fg

      local fmt = function(val)
        return val and string.format("#%06x", val) or nil
      end

      local set_groups = {}

      for _, mode in ipairs(modes) do
        local mode_color = fmt(highlights_utils.get_hl("lualine_a_" .. mode).bg)

        for _, prefix in ipairs({ "lualine_a_", "lualine_z_" }) do
          local group = prefix .. mode
          vim.api.nvim_set_hl(0, group, { fg = mode_color, bold = true })
          set_groups[group] = true
        end

        for _, prefix in ipairs({ "lualine_b_", "lualine_y_" }) do
          local group = prefix .. mode
          vim.api.nvim_set_hl(0, group, { fg = fmt(normal_fg) })
          set_groups[group] = true
        end

        for _, prefix in ipairs({ "lualine_c_", "lualine_x_" }) do
          local group = prefix .. mode
          vim.api.nvim_set_hl(0, group, { fg = fmt(conceal_fg) })
          set_groups[group] = true
        end
      end

      local all_hls = vim.api.nvim_get_hl(0, {})
      for group_name, hl in pairs(all_hls) do
        if group_name:match("^lualine") and not set_groups[group_name] then
          hl.bg = nil
          vim.api.nvim_set_hl(0, group_name, hl)
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
