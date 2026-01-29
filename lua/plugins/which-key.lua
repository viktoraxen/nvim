return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  config = function()
    require("which-key").setup({
      icons = { rules = false },
      delay = 500,
    })
  end,
}
