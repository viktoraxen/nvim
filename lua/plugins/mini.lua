return {
  "nvim-mini/mini.nvim",
  version = false,
  config = function()
    require("mini.icons").setup()
    MiniIcons.mock_nvim_web_devicons()
    require("mini.ai").setup({ n_lines = 500 })
    require("mini.move").setup()
    require("mini.align").setup()
    require("mini.comment").setup()
    require("mini.surround").setup()
    require("mini.operators").setup()
    require("mini.splitjoin").setup()
  end,
}
