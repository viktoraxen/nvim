local configs = require("plugins.snacks.configs")

local function toggle_terminal(id)
  Snacks.terminal.toggle("zsh", { env = { id = id } })
end

local function pick(key, picker, config, desc)
  return {
    key,
    function()
      picker(config)
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
  pick("<leader>f", Snacks.picker.files, configs.vscode, "Search files"),
  pick("<leader>F", Snacks.picker.files, configs.vscode_all, "Search files (All)"),
  pick("<leader>b", Snacks.picker.buffers, configs.vscode, "Search buffers"),
  pick("<leader>sb", Snacks.picker.buffers, nil, "Buffers"),
  pick("<leader>sc", Snacks.picker.colorschemes, nil, "Colorschemes"),
  pick("<leader>sd", Snacks.picker.diagnostics, nil, "Diagnostics"),
  pick("<leader>sD", Snacks.picker.diagnostics, configs.all, "Diagnostics (All)"),
  pick("<leader>sf", Snacks.picker.files, nil, "Files"),
  pick("<leader>sF", Snacks.picker.files, configs.all, "Files (All)"),
  pick("<leader>sg", Snacks.picker.git_diff, configs.git_status, "Git files (All)"),
  pick("<leader>ss", Snacks.picker.grep, nil, "Grep"),
  pick("<leader>sS", Snacks.picker.grep, configs.all, "Grep (All)"),
  pick("<leader>sh", Snacks.picker.help, nil, "Help"),
  pick("<leader>sH", Snacks.picker.highlights, nil, "Highlights"),
  pick("<leader>si", Snacks.picker.icons, configs.vscode, "Icons"),
  pick("<leader>sw", Snacks.picker.lsp_symbols, nil, "Symbols"),
  pick("<leader>sW", Snacks.picker.lsp_workspace_symbols, nil, "Workspace symbols"),
  pick("<leader>sp", Snacks.picker.projects, nil, "Projects"),
  pick("<leader>sP", Snacks.picker.pickers, configs.vscode, "Pickers"),
  pick("<leader>sr", Snacks.picker.resume, nil, "Resume"),
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
  opts = {
    bigfile = { enabled = true },
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
  },
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
      SnacksPickerPrompt = "NormalFloat",

      SnacksPickerPreview = "DarkFloat",
      SnacksPickerPreviewBorder = "SnacksPickerPreview",
      SnacksPickerPreviewFooter = "SnacksPickerPreview",
      SnacksPickerPreviewNormal = "SnacksPickerPreview",
      SnacksPickerPreviewTitle = "DarkFloatTitle",

      SnacksPickerListBorder = "SnacksPickerList",
      SnacksPickerListCursorLine = "LightFloat",
    })

    require("highlights-nvim").add({
      customizations = {
        ["*"] = {
          SnacksPickerGitStatusStaged = { italic = false },
          SnacksPickerGitStatusModified = { italic = false },
          SnacksIndent = { bg = false },
        },
        catppuccin = {
          SnacksIndent = { fg = "surface0" },
        },
      },
      links = { ["*"] = links },
    })

    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
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
