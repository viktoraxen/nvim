return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-mini/mini.nvim" },
  event = "VeryLazy",
  config = function()
    local di = require("config").icons.diagnostics

    local disabled_statusline_fts = {
      "snacks_dashboard",
    }

    local disabled_winbar_fts = {
      "neo%-tree",
      "snacks",
      "sidekick",
      "snacks_dashboard",
      "tmux",
      "codediff-explorer",
      "checkhealth",
    }

    local disabled_filetypes = {
      "snacks",
      "neo%-tree",
      "codediff",
      "sidekick",
    }

    local function is_codediff_win()
      return vim.w.codediff_restore == 1
    end

    local function matches_any(ft, patterns)
      for _, pat in ipairs(patterns) do
        if ft:match(pat) then
          return true
        end
      end
      return false
    end

    local function is_enabled_filetype()
      return not matches_any(vim.bo.ft, disabled_filetypes)
    end

    local function is_enabled_winbar()
      if vim.bo.buftype == "terminal" then
        return false
      end
      if is_codediff_win() then
        return false
      end
      return not matches_any(vim.bo.ft, disabled_winbar_fts)
    end

    local rev_name_cache = {}

    local function get_ref_name(rev, git_root)
      if not git_root or not rev or #rev ~= 40 or not rev:match("^%x+$") then
        return nil
      end
      if rev_name_cache[rev] then
        return rev_name_cache[rev]
      end
      for _, ref in ipairs({ "HEAD", "HEAD~1", "HEAD~2", "HEAD~3" }) do
        local hash = vim.trim(vim.fn.system({ "git", "-C", git_root, "rev-parse", ref }))
        if vim.v.shell_error == 0 and #hash == 40 then
          rev_name_cache[hash] = ref
        end
      end
      return rev_name_cache[rev]
    end

    local function format_rev(rev, git_root)
      if rev == nil or rev == "WORKING" then
        return nil
      elseif rev == ":0" then
        return "Staged"
      elseif rev == ":2" then
        return "Current (ours)"
      elseif rev == ":3" then
        return "Incoming (theirs)"
      elseif #rev == 40 and rev:match("^%x+$") then
        return get_ref_name(rev, git_root) or rev:sub(1, 7)
      else
        return rev
      end
    end

    local function codediff_label()
      local ok, lifecycle = pcall(require, "codediff.ui.lifecycle")
      if not ok then
        return ""
      end

      local bufnr = vim.api.nvim_get_current_buf()
      local tabpage = lifecycle.find_tabpage_by_buffer(bufnr)
      if not tabpage then
        return ""
      end

      local session = lifecycle.get_session(tabpage)
      if not session then
        return ""
      end

      local filename, rev
      if bufnr == session.original_bufnr then
        filename = vim.fn.fnamemodify(session.original_path or "", ":t")
        rev = session.original_revision
      elseif bufnr == session.modified_bufnr then
        filename = vim.fn.fnamemodify(session.modified_path or "", ":t")
        rev = session.modified_revision
      elseif session.result_bufnr and bufnr == session.result_bufnr then
        filename = vim.fn.fnamemodify(session.modified_path or "", ":t")
        return filename .. " — Merge result"
      else
        return ""
      end

      local ref_name = format_rev(rev, session.git_root)
      if ref_name then
        return filename .. " at " .. ref_name
      end
      return filename .. " — Current"
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

    local padding = 2

    local filename_component = {
      "filename",
      file_status = true,
      symbols = { modified = " ●", readonly = " 󰌾" },
      icon = "󰧮",
      cond = is_enabled_winbar,
      padding = padding,
    }

    local filepath_component = { filepath, cond = is_enabled_winbar, padding = padding }

    local codediff_component = {
      codediff_label,
      icon = "󰧮",
      cond = is_codediff_win,
      padding = padding,
    }

    require("lualine").setup({
      options = {
        icons_enabled = true,
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = { statusline = disabled_statusline_fts, winbar = disabled_winbar_fts },
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
            padding = padding,
          },
        },
        lualine_b = {
          -- { git_file_status, cond = is_enabled_ft },
        },
        lualine_c = {
          {
            function()
              return " "
            end,
            cond = function()
              return package.loaded["copilot"] ~= nil and not require("copilot.client").is_disabled()
            end,
            padding = padding,
          },
          {
            "diagnostics",
            padding = { left = 1, right = padding },
            symbols = {
              error = " " .. di.error .. " ",
              warn = " " .. di.warn .. " ",
              info = " " .. di.info .. " ",
              hint = " " .. di.hint .. " ",
            },
            update_in_insert = true,
          },
        },
        lualine_x = {
          { "branch", icon = "", padding = padding },
          { venv, icon = "󰹩", padding = padding },
        },
        lualine_y = {
          { "searchcount", padding = padding },
          {
            "filetype",
            cond = is_enabled_filetype,
            colored = true,
            icon_only = true,
            padding = { left = padding, right = 1 },
            color = { bg = vim.NIL },
          },
          {
            function()
              return vim.bo.filetype
            end,
            cond = is_enabled_filetype,
            padding = { left = 0, right = padding },
          },
        },
        lualine_z = {
          { "progress", padding = { left = padding, right = 1 } },
          { "location", padding = { left = 0, right = padding } },
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
        lualine_b = { codediff_component, filename_component },
        lualine_c = { filepath_component },
      },
      inactive_winbar = {
        lualine_b = { codediff_component, filename_component },
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
        customizations = {
          ["*"] = {
            StatusLine = { fg = "Normal", bg = "Normal" },
          },
        },
        links = {
          ["*"] = {
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
