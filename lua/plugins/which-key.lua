return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  config = function()
    require("which-key").setup({
      icons = { rules = false },
      delay = 500,
    })
    require("utils.keymap")._flush_groups()
  end,
}
