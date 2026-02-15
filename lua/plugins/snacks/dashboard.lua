local configs = require("plugins.snacks.configs")

local function open_config()
  vim.cmd("cd ~/.config/nvim")
  require("persistence").load()
end

return {
  enabled = true,
  wo = { winblend = 0 },
  sections = {
    { padding = 1 },
    { section = "header" },
    { section = "keys", padding = 1 },
    { section = "startup" },
  },
  preset = {
    keys = {
      { icon = " ", key = "n", desc = "New file", action = ":ene", padding = 1 },
      {
        icon = " ",
        key = "f",
        desc = "Find files",
        action = function()
          Snacks.picker.files()
        end,
        padding = 1,
      },
      {
        icon = " ",
        key = "p",
        desc = "Projects",
        action = function()
          Snacks.picker.projects(configs.vscode)
        end,
        padding = 1,
      },
      {
        icon = " ",
        key = "r",
        desc = "Restore session",
        action = function()
          require("persistence").load({ last = true })
        end,
        padding = 1,
      },
      { icon = " ", key = "l", desc = "Plugins", action = ":Lazy", padding = 1 },
      { icon = " ", key = "m", desc = "Mason", action = ":Mason", padding = 1 },
      { icon = " ", key = "c", desc = "Configuration", action = open_config, padding = 1 },
      { icon = "󱎘 ", key = "q", desc = "Quit", action = ":qa", padding = 1 },
    },
  },
}
