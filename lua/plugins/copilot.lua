return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  config = function()
    require("copilot").setup({
      panel = {
        auto_refresh = true,
        keymap = {
          jump_prev = "<M-k>",
          jump_next = "<M-j>",
        },
      },
      suggestion = {
        auto_trigger = true,
        keymap = {
          next = "<M-n>",
          prev = "<M-p>",
          dismiss = "<M-d>",
        },
      },
    })
  end,
  keys = {
    { "<leader>ce", ":Copilot enable<cr>", desc = "Enable CoPilot" },
    { "<leader>cd", ":Copilot disable<cr>", desc = "Disable CoPilot" },
    { "<leader>cc", ":Copilot toggle<cr>", desc = "Toggle CoPilot" },
  },
}
