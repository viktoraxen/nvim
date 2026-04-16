local layouts = require("config.snacks.layouts")

require("which-key").add({
  mode = { "n" },

  { "<leader>b", "<cmd>Picker buffers vscode<cr>", desc = "Search buffers" },
  { "<leader>f", "<cmd>Picker files vscode<cr>", desc = "Search files" },
  { "<leader>F", "<cmd>Picker files vscode_all<cr>", desc = "Search files (All)" },

  { "<leader>s", group = "Search" },

  { "<leader>sb", "<cmd>Picker buffers<cr>", desc = "Buffers" },
  { "<leader>sc", "<cmd>Picker colorschemes<cr>", desc = "Colorschemes" },
  { "<leader>sd", "<cmd>Picker diagnostics<cr>", desc = "Diagnostics" },
  { "<leader>sD", "<cmd>Picker diagnostics all<cr>", desc = "Diagnostics (All)" },
  { "<leader>sf", "<cmd>Picker files<cr>", desc = "Files" },
  { "<leader>sF", "<cmd>Picker files all<cr>", desc = "Files (All)" },
  { "<leader>sg", "<cmd>Picker git_diff<cr>", desc = "Git diff" },
  { "<leader>ss", "<cmd>Picker grep<cr>", desc = "Grep" },
  { "<leader>sS", "<cmd>Picker grep all<cr>", desc = "Grep (All)" },
  { "<leader>sh", "<cmd>Picker help<cr>", desc = "Help" },
  { "<leader>sH", "<cmd>Picker highlights<cr>", desc = "Highlights" },
  { "<leader>si", "<cmd>Picker icons vscode<cr>", desc = "Icons" },
  { "<leader>sw", "<cmd>Picker lsp_symbols<cr>", desc = "LSP Symbols" },
  { "<leader>sW", "<cmd>Picker lsp_workspace_symbols<cr>", desc = "LSP Workspace Symbols" },
  { "<leader>sp", "<cmd>Picker projects vscode<cr>", desc = "Projects" },
  { "<leader>sP", "<cmd>Picker pickers vscode<cr>", desc = "Pickers" },
  {
    "<leader>sr",
    function()
      Snacks.picker.resume()
    end,
    desc = "Resume",
  },
})

return {
  prompt = "  ",
  layout = layouts.adaptive_width(layouts.wide, layouts.narrow),
  matcher = { frecency = true },
  ui_select = true,
  layouts = { select = layouts.vscode },
  win = {
    input = {
      keys = {
        ["<c-d>"] = { "preview_scroll_down", mode = { "i", "n" } },
        ["<c-u>"] = { "preview_scroll_up", mode = { "i", "n" } },
        ["<c-l>"] = { "focus_preview", mode = { "n", "i" } },
      },
    },
    list = {
      keys = {
        ["<c-c>"] = "close",
        ["<c-k>"] = "focus_input",
        ["<c-l>"] = "focus_preview",
      },
    },
    preview = {
      keys = {
        ["<c-c>"] = "close",
        ["<c-h>"] = "focus_input",
        ["<c-l>"] = "confirm",
      },
    },
  },
}
