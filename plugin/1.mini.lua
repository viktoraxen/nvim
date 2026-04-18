vim.pack.add({ "https://github.com/nvim-mini/mini.nvim" })

require("mini.icons").setup()
MiniIcons.mock_nvim_web_devicons()

vim.schedule(function()
  require("mini.ai").setup({ n_lines = 500 })
  require("mini.move").setup()
  require("mini.align").setup()
  -- require("mini.surround").setup()
  require("mini.splitjoin").setup()
  -- require("mini.pairs").setup()
  require("mini.cursorword").setup()
end)
