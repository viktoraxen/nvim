vim.schedule(function()
  vim.pack.add({
    "https://github.com/MeanderingProgrammer/render-markdown.nvim",
    "https://github.com/nvim-treesitter/nvim-treesitter",
    "https://github.com/nvim-mini/mini.nvim",
  })

  require("render-markdown").setup({
    anti_conceal = {
      enabled = false,
      ignore = {
        table_border = true,
      },
    },
    heading = {
      sign = false,
      position = "inline",
    },
    code = {
      sign = false,
      border = "thick",
      inline_pad = 1,
      left_pad = 2,
    },
    overrides = {
      buftype = {
        nofile = {
          code = {
            left_pad = 0,
            right_pad = 0,
            disable_background = true,
            border = "hide",
            language = false,
          },
        },
      },
    },
  })
end)
