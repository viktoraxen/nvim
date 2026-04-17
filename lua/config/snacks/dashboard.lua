require("which-key").add({
  mode = { "n" },

  { "<leader>A", "<cmd>Dashboard<cr>", desc = "Dashboard" },
})

local utils = require("utils")

return {
  sections = {
    { padding = 1 },
    { section = "header" },
    { section = "keys", padding = 1 },
    function()
      return {
        align = "center",
        text = { { "Neovim started in ", hl = "Normal" }, { utils.get_running_time() .. "ms", hl = "special" } },
      }
    end,
  },
  preset = {
    keys = {
      { icon = "󱪞 ", key = "n", desc = "New file", action = ":ene", padding = 1 },
      { icon = "󰍉 ", key = "f", desc = "Find files", action = ":Picker files", padding = 1 },
      { icon = "󰉖 ", key = "p", desc = "Projects", action = ":Picker projects vscode", padding = 1 },
      { icon = "󰜉 ", key = "r", desc = "Restore session", action = ":Restore", padding = 1 },
      { icon = "󱐥 ", key = "u", desc = "Update plugins", action = ":Packupdate", padding = 1 },
      { icon = "󰏗 ", key = "m", desc = "Mason", action = ":Mason", padding = 1 },
      { icon = "󰢻 ", key = "c", desc = "Configuration", action = ":Config", padding = 1 },
      { icon = "󱎘 ", key = "q", desc = "Quit", action = ":qa", padding = 1 },
    },
  },
}
