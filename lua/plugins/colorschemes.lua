return {
  {
    "folke/tokyonight.nvim",
    lazy = true,
    opts = {},
  },
  {
    "rebelot/kanagawa.nvim",
  },
  {
    "catppuccin/nvim",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavor = "mocha",
      })
    end,
  },
}
