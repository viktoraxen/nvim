local configs = require("plugins.snacks.configs")

local tmux_warned = false

local function ensure_tmux_conf()
  local conf_dir = vim.fn.stdpath("data") .. "/tmux"
  local conf_path = conf_dir .. "/persistent.conf"

  if vim.uv.fs_stat(conf_path) then
    return conf_path
  end

  vim.fn.mkdir(conf_dir, "p")
  local f = assert(io.open(conf_path, "w"))
  f:write(table.concat({
    "set -g status off",
    "set -g prefix None",
    "set -g escape-time 0",
    "set -g detach-on-destroy on",
    "set -g mouse off",
  }, "\n") .. "\n")
  f:close()
  return conf_path
end

local function tmux_session_name(id)
  local cwd = vim.fn.getcwd()
  local hash = vim.fn.sha256(cwd):sub(1, 8)
  return ("nvim_%s_%d"):format(hash, id)
end

local function toggle_terminal(id)
  -- if vim.fn.executable("tmux") == 1 then
  --   local conf = ensure_tmux_conf()
  --   local session = tmux_session_name(id)
  --   Snacks.terminal.toggle({
  --     "tmux",
  --     "-L",
  --     "nvim",
  --     "-f",
  --     conf,
  --     "new-session",
  --     "-A",
  --     "-s",
  --     session,
  --   }, { env = { id = id } })
  -- else
  --   if not tmux_warned then
  --     tmux_warned = true
  --     vim.notify("tmux not found — terminal sessions won't persist", vim.log.levels.WARN)
  --   end
  Snacks.terminal.toggle("zsh", { env = { id = id } })
  -- end
end

local function pick(key, method, config, desc)
  return {
    key,
    function()
      Snacks.picker[method](config)
    end,
    desc = desc,
  }
end

local lsp_pickers = {
  { key = "c", fn = "lsp_declarations", desc = "Declarations" },
  { key = "d", fn = "lsp_definitions", desc = "Definitions" },
  { key = "i", fn = "lsp_implementations", desc = "Implementation" },
  { key = "r", fn = "lsp_references", desc = "References" },
  { key = "t", fn = "lsp_type_definitions", desc = "Type definitions" },
}

local keys = {
  {
    "<leader>A",
    function()
      Snacks.dashboard()
    end,
    desc = "Dashboard",
  },
  pick("<leader>f", "files", configs.vscode, "Search files"),
  pick("<leader>F", "files", configs.vscode_all, "Search files (All)"),
  pick("<leader>b", "buffers", configs.vscode, "Search buffers"),
  pick("<leader>sb", "buffers", nil, "Buffers"),
  pick("<leader>sc", "colorschemes", nil, "Colorschemes"),
  pick("<leader>sd", "diagnostics", nil, "Diagnostics"),
  pick("<leader>sD", "diagnostics", configs.all, "Diagnostics (All)"),
  pick("<leader>sf", "files", nil, "Files"),
  pick("<leader>sF", "files", configs.all, "Files (All)"),
  pick("<leader>sg", "git_diff", configs.git_status, "Git files (All)"),
  pick("<leader>ss", "grep", nil, "Grep"),
  pick("<leader>sS", "grep", configs.all, "Grep (All)"),
  pick("<leader>sh", "help", nil, "Help"),
  pick("<leader>sH", "highlights", nil, "Highlights"),
  pick("<leader>si", "icons", configs.vscode, "Icons"),
  pick("<leader>sw", "lsp_symbols", nil, "Symbols"),
  pick("<leader>sW", "lsp_workspace_symbols", nil, "Workspace symbols"),
  pick("<leader>sp", "projects", configs.vscode, "Projects"),
  pick("<leader>sP", "pickers", configs.vscode, "Pickers"),
  pick("<leader>sr", "resume", nil, "Resume"),
}

for _, lsp in ipairs(lsp_pickers) do
  keys[#keys + 1] = {
    "gr" .. lsp.key,
    function()
      Snacks.picker[lsp.fn]()
    end,
    desc = lsp.desc,
  }
  keys[#keys + 1] = {
    "<leader>l" .. lsp.key,
    function()
      Snacks.picker[lsp.fn]()
    end,
    desc = lsp.desc,
  }
end

for i = 1, 9 do
  keys[#keys + 1] = {
    "<M-" .. i .. ">",
    function()
      toggle_terminal(i)
    end,
    desc = "Toggle terminal " .. i,
    mode = { "n", "i", "v", "t" },
  }
end

local notifier_links = {}
for _, level in ipairs({ "Trace", "Debug", "Info", "Warn", "Error" }) do
  notifier_links["SnacksNotifierBorder" .. level] = "NormalFloat"
  notifier_links["SnacksNotifier" .. level] = "NormalFloat"
end

return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = function()
    return {
      bigfile = { enabled = true },
      dashboard = require("plugins.snacks.dashboard"),
      bufdelete = { enabled = true },
      debug = { enabled = true },
      indent = require("plugins.snacks.indent"),
      input = require("plugins.snacks.input"),
      notifier = require("plugins.snacks.notifier"),
      picker = require("plugins.snacks.picker"),
      quickfile = { enabled = true },
      rename = { enabled = true },
      scope = { enabled = true },
      scroll = require("plugins.snacks.scroll"),
      terminal = require("plugins.snacks.terminal"),
      words = { enabled = true },
      styles = require("plugins.snacks.styles"),
    }
  end,
  keys = keys,
  init = function()
    local picker_input_links = {
      SnacksPickerInput = "LightFloat",
      SnacksPickerInputBorder = "SnacksPickerInput",
      SnacksPickerInputLine = "SnacksPickerInput",
      SnacksPickerInputFooter = "SnacksPickerInput",
      SnacksPickerInputSearch = "SnacksPickerInput",
      SnacksPickerInputCursorLine = "SnacksPickerInput",
      SnacksPickerInputTitle = "LightFloatTitle",
    }

    local snacks_input_links = {
      SnacksInputNormal = "LightFloat",
      SnacksInputIcon = "SnacksInputNormal",
      SnacksInputBorder = "SnacksInputNormal",
      SnacksInputTitle = "SnacksInputNormal",
      SnacksInputCursorLine = "SnacksInputNormal",
    }

    local links = vim.tbl_extend("force", notifier_links, picker_input_links, snacks_input_links, {
      SnacksPickerToggle = "SnacksPickerInputTitle",
      SnacksPickerPrompt = "SnacksPickerInputTitle",

      SnacksPickerPreview = "DarkFloat",
      SnacksPickerPreviewBorder = "SnacksPickerPreview",
      SnacksPickerPreviewFooter = "SnacksPickerPreview",
      SnacksPickerPreviewNormal = "SnacksPickerPreview",
      SnacksPickerPreviewTitle = "DarkFloatTitle",

      SnacksPickerListBorder = "SnacksPickerList",
      SnacksPickerListCursorLine = "LightFloat",
    })

    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        require("highlights-nvim").add({
          customizations = {
            ["*"] = {
              SnacksPickerGitStatusStaged = { italic = false },
              SnacksPickerGitStatusModified = { italic = false },
              SnacksIndent = { bg = false },
              SnacksInputIcon = { fg = "FloatTitle", bg = "LightFloat" },
            },
            catppuccin = {
              SnacksIndent = { fg = "surface0" },
            },
          },
          links = { ["*"] = links },
        })

        _G.dd = function(...)
          Snacks.debug.inspect(...)
        end
        _G.bt = function()
          Snacks.debug.backtrace()
        end
        vim.print = _G.dd
      end,
    })
  end,
}
