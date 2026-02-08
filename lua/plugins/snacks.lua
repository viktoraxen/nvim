local configs = require("plugins.snacks.configs")

local function toggle_terminal(id)
  Snacks.terminal.toggle("zsh", { env = { id = id } })
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
  keys = {
    {
      "grc",
      function()
        Snacks.picker.lsp_declarations()
      end,
      desc = "Go to declaration",
    },
    {
      "grd",
      function()
        Snacks.picker.lsp_definitions()
      end,
      desc = "Go to definition",
    },
    {
      "gri",
      function()
        Snacks.picker.lsp_implementations()
      end,
      desc = "Implementation",
    },
    {
      "grr",
      function()
        Snacks.picker.lsp_references()
      end,
      desc = "References",
    },
    {
      "grt",
      function()
        Snacks.picker.lsp_type_definitions()
      end,
      desc = "Go to type definition",
    },

    {
      "<leader>lc",
      function()
        Snacks.picker.lsp_declarations()
      end,
      desc = "Declarations",
    },
    {
      "<leader>ld",
      function()
        Snacks.picker.lsp_definitions()
      end,
      desc = "Definitions",
    },
    {
      "<leader>li",
      function()
        Snacks.picker.lsp_implementations()
      end,
      desc = "Implementation",
    },
    {
      "<leader>lr",
      function()
        Snacks.picker.lsp_references()
      end,
      desc = "References",
    },
    {
      "<leader>lt",
      function()
        Snacks.picker.lsp_type_definitions()
      end,
      desc = "Type definitions",
    },

    {
      "<leader>f",
      function()
        Snacks.picker.files(configs.vscode)
      end,
      desc = "Search files",
    },
    {
      "<leader>F",
      function()
        Snacks.picker.files(configs.vscode_all)
      end,
      desc = "Search files (All)",
    },
    {
      "<leader>b",
      function()
        Snacks.picker.buffers(configs.vscode)
      end,
      desc = "Search buffers",
    },
    {
      "<leader>sb",
      function()
        Snacks.picker.buffers()
      end,
      desc = "Buffers",
    },
    {
      "<leader>sc",
      function()
        Snacks.picker.colorschemes()
      end,
      desc = "Colorschemes",
    },
    {
      "<leader>sd",
      function()
        Snacks.picker.diagnostics()
      end,
      desc = "Diagnostics",
    },
    {
      "<leader>sD",
      function()
        Snacks.picker.diagnostics(configs.all)
      end,
      desc = "Diagnostics (All)",
    },
    {
      "<leader>sf",
      function()
        Snacks.picker.files()
      end,
      desc = "Files",
    },
    {
      "<leader>sF",
      function()
        Snacks.picker.files(configs.all)
      end,
      desc = "Files (All)",
    },
    {
      "<leader>sg",
      function()
        Snacks.picker.git_diff(configs.git_status)
      end,
      desc = "Git files (All)",
    },
    {
      "<leader>ss",
      function()
        Snacks.picker.grep()
      end,
      desc = "Grep",
    },
    {
      "<leader>sS",
      function()
        Snacks.picker.grep(configs.all)
      end,
      desc = "Grep (All)",
    },
    {
      "<leader>sh",
      function()
        Snacks.picker.help()
      end,
      desc = "Help",
    },
    {
      "<leader>sH",
      function()
        Snacks.picker.highlights()
      end,
      desc = "Highlights",
    },
    {
      "<leader>si",
      function()
        Snacks.picker.icons(configs.vscode)
      end,
      desc = "Icons",
    },
    {
      "<leader>sw",
      function()
        Snacks.picker.lsp_symbols()
      end,
      desc = "Symbols",
    },
    {
      "<leader>sW",
      function()
        Snacks.picker.lsp_workspace_symbols()
      end,
      desc = "Workspace symbols",
    },
    {
      "<leader>sp",
      function()
        Snacks.picker.projects()
      end,
      desc = "Projects",
    },
    {
      "<leader>sP",
      function()
        Snacks.picker.pickers(configs.vscode)
      end,
      desc = "Pickers",
    },
    {
      "<leader>sr",
      function()
        Snacks.picker.resume()
      end,
      desc = "Resume",
    },

    {
      "<M-1>",
      function()
        toggle_terminal(1)
      end,
      desc = "Toggle terminal",
      mode = { "n", "i", "v", "t" },
    },
    {
      "<M-2>",
      function()
        toggle_terminal(2)
      end,
      desc = "Toggle terminal",
      mode = { "n", "i", "v", "t" },
    },
    {
      "<M-3>",
      function()
        toggle_terminal(3)
      end,
      desc = "Toggle terminal",
      mode = { "n", "i", "v", "t" },
    },
    {
      "<M-4>",
      function()
        toggle_terminal(4)
      end,
      desc = "Toggle terminal",
      mode = { "n", "i", "v", "t" },
    },
    {
      "<M-5>",
      function()
        toggle_terminal(5)
      end,
      desc = "Toggle terminal",
      mode = { "n", "i", "v", "t" },
    },
    {
      "<M-6>",
      function()
        toggle_terminal(6)
      end,
      desc = "Toggle terminal",
      mode = { "n", "i", "v", "t" },
    },
    {
      "<M-7>",
      function()
        toggle_terminal(7)
      end,
      desc = "Toggle terminal",
      mode = { "n", "i", "v", "t" },
    },
    {
      "<M-8>",
      function()
        toggle_terminal(8)
      end,
      desc = "Toggle terminal",
      mode = { "n", "i", "v", "t" },
    },
    {
      "<M-9>",
      function()
        toggle_terminal(9)
      end,
      desc = "Toggle terminal",
      mode = { "n", "i", "v", "t" },
    },
  },
  init = function()
    require("highlights-nvim").add({
      customizations = {
        SnacksPickerGitStatusStaged = { italic = false },
        SnacksPickerGitStatusModified = { italic = false },

        catppuccin = {
          SnacksIndent = { fg = "surface0" },
        },
      },
      links = {
        SnacksPickerToggle = "SnacksPickerInputTitle",

        SnacksNotifierBorderTrace = "NormalFloat",
        SnacksNotifierBorderDebug = "NormalFloat",
        SnacksNotifierBorderInfo = "NormalFloat",
        SnacksNotifierBorderWarn = "NormalFloat",
        SnacksNotifierBorderError = "NormalFloat",

        SnacksNotifierTrace = "NormalFloat",
        SnacksNotifierDebug = "NormalFloat",
        SnacksNotifierInfo = "NormalFloat",
        SnacksNotifierWarn = "NormalFloat",
        SnacksNotifierError = "NormalFloat",

        SnacksPickerInput = "LightFloat",
        SnacksPickerInputBorder = "SnacksPickerInput",
        SnacksPickerInputLine = "SnacksPickerInput",
        SnacksPickerInputFooter = "SnacksPickerInput",
        SnacksPickerInputSearch = "SnacksPickerInput",
        SnacksPickerInputCursorLine = "SnacksPickerInput",
        SnacksPickerInputTitle = "LightFloatTitle",

        SnacksPickerPrompt = "NormalFloat",

        SnacksPickerPreview = "DarkFloat",
        SnacksPickerPreviewBorder = "SnacksPickerPreview",
        SnacksPickerPreviewFooter = "SnacksPickerPreview",
        SnacksPickerPreviewNormal = "SnacksPickerPreview",
        SnacksPickerPreviewTitle = "DarkFloatTitle",

        SnacksPickerListBorder = "SnacksPickerList",
        SnacksPickerListCursorLine = "LightFloat",

        SnacksInputNormal = "LightFloat",
        SnacksInputBorder = "SnacksInputNormal",
        SnacksInputTitle = "SnacksInputNormal",
        SnacksInputCursorLine = "SnacksInputNormal",
      },
    })

    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        -- Setup some globals for debugging (lazy-loaded)
        _G.dd = function(...)
          Snacks.debug.inspect(...)
        end
        _G.bt = function()
          Snacks.debug.backtrace()
        end
        vim.print = _G.dd -- Override print to use snacks for `:=` command
      end,
    })
  end,
}
