vim.schedule(function()
  vim.pack.add({
    {
      src = "https://github.com/nvim-neo-tree/neo-tree.nvim",
      version = vim.version.range("3"),
    },
    {
      src = "https://github.com/s1n7ax/nvim-window-picker",
      version = vim.version.range("2"),
    },
    "https://github.com/nvim-lua/plenary.nvim",
    "https://github.com/MunifTanjim/nui.nvim",
    "https://github.com/nvim-mini/mini.nvim",
  })

  local solid_open = false

  local function after_close(_)
    solid_open = false
  end

  local function file_opened()
    if not solid_open then
      require("neo-tree.command").execute({ action = "close" })
    end
  end

  local function buffer_leave(_)
    if not solid_open then
      require("neo-tree.command").execute({ action = "close" })
    end
  end

  local function on_move(data)
    Snacks.rename.on_rename_file(data.source, data.destination)
  end

  local events = require("neo-tree.events")
  local fs_components = require("neo-tree.sources.filesystem.components")

  fs_components.python_package = function(_, node)
    if node.type == "directory" and vim.uv.fs_stat(node.path .. "/__init__.py") then
      return { text = " 󰌠 ", highlight = "Comment" }
    end
    return {}
  end

  require("neo-tree").setup({
    use_popups_for_input = false,
    popup_border_style = "solid",
    event_handlers = {
      { event = events.FILE_MOVED, handler = on_move },
      { event = events.FILE_RENAMED, handler = on_move },
      { event = "neo_tree_window_after_close", handler = after_close },
      { event = "file_opened", handler = file_opened },
      { event = "neo_tree_buffer_leave", handler = buffer_leave },
    },
    filesystem = {
      use_trash = true,
      filtered_items = {
        show_hidden_count = false,
        hide_dotfiles = false,
        hide_by_name = { "__init__.py" },
        never_show = { ".git" },
      },
    },
    default_component_configs = {
      diagnostics = {
        symbols = {
          hint = "h",
          info = "i",
          warn = "w",
          error = "e",
        },
      },
      modified = {
        symbol = "~",
      },
      name = { use_git_status_colors = false },
      git_status = {
        symbols = {
          -- Change type
          added = "a",
          modified = "m",
          deleted = "d",
          renamed = "r",

          -- Status type
          untracked = "n",
          ignored = "i",
          unstaged = "u",
          staged = "s",
          conflict = "c",
        },
      },
    },
    window = {
      width = 33,
      mappings = {
        ["<cr>"] = "open_with_window_picker",
        ["o"] = "open",
        ["-"] = "navigate_up",
        ["l"] = "open_with_window_picker",
        ["s"] = "split_with_window_picker",
        ["v"] = "vsplit_with_window_picker",
        ["c"] = "copy_to_clipboard",
        ["p"] = "paste_from_clipboard",
        ["K"] = "show_file_details",
      },
    },
  })

  -- Hide the cursor in neo-tree windows. This is tricky because:
  -- - guicursor is global, so we must save/restore it on window transitions
  -- - snacks_input floats open with noautocmd, so we wrap vim.ui.input to
  --   restore the cursor before the input and re-hide it in the callback

  vim.api.nvim_set_hl(0, "HiddenCursor", { blend = 100, nocombine = true })

  local saved_guicursor = vim.o.guicursor
  local cursor_hidden = false

  local function hide_cursor()
    if cursor_hidden then
      return
    end
    saved_guicursor = vim.o.guicursor
    cursor_hidden = true
    vim.o.guicursor = "a:HiddenCursor"
  end

  local function show_cursor()
    if not cursor_hidden then
      return
    end
    cursor_hidden = false
    vim.o.guicursor = saved_guicursor
  end

  local function sync_cursor()
    if vim.bo.filetype == "neo-tree" then
      hide_cursor()
    else
      show_cursor()
      if vim.wo.cursorline then
        vim.wo.cursorline = false
      end
    end
  end

  local input_wrapped = false

  vim.api.nvim_create_autocmd({ "BufEnter", "WinEnter", "WinClosed" }, {
    desc = "Sync neo-tree cursor visibility and wrap vim.ui.input",
    callback = function(ev)
      if ev.event == "WinClosed" then
        vim.schedule(sync_cursor)
        return
      end

      sync_cursor()

      -- Lazily wrap vim.ui.input once snacks has replaced it, so that
      -- dialogs opened from neo-tree (e.g. rename) show a visible cursor.
      if not input_wrapped and vim.bo.filetype == "neo-tree" then
        input_wrapped = true
        local orig = vim.ui.input
        vim.ui.input = function(opts, on_confirm)
          local was_hidden = cursor_hidden
          if was_hidden then
            show_cursor()
          end
          return orig(opts, function(...)
            if was_hidden and vim.bo.filetype == "neo-tree" then
              hide_cursor()
            end
            return on_confirm(...)
          end)
        end
      end
    end,
  })

  require("window-picker").setup({
    hint = "statusline-winbar",
    show_prompt = false,
  })

  local function neo_tree()
    if vim.bo.filetype == "neo-tree" then
      vim.cmd("Neotree close")
    elseif solid_open then
      vim.cmd("Neotree focus")
    else
      vim.cmd("Neotree right")
    end
  end

  local function neo_tree_solid()
    if vim.bo.filetype == "neo-tree" then
      vim.cmd("Neotree close")
    else
      vim.cmd("Neotree right")
      solid_open = true
    end
  end

  require("which-key").add({
    { "<leader>e", neo_tree, desc = "Neo-tree" },
    { "<leader>E", neo_tree_solid, desc = "Neo-tree (Solid)" },
  })

  require("highlight-utils").link({
    NeoTreeNormal = "Normal",
    NeoTreeNormalNC = "NeoTreeNormal",
    NeoTreeEndOfBuffer = "NeoTreeNormal",

    WindowPickerStatusLineNC = "DiagnosticOk",
    WindowPickerStatusLine = "DiagnosticError",
    WindowPickerWinbarNC = "DiagnosticOk",
    WindowPickerWinbar = "DiagnosticError",
  })
end)
