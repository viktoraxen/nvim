require('lazy').setup({
  { import = 'plugins' },
  { import = 'plugins.colorschemes' },
}, {
  install = {
    colorscheme = { 'catppuccin' },
  },
  ui = {
    border = 'solid',
    backdrop = 100,
    size = { width = 0.85, height = 0.85 },
  },
  dev = {
    path = '~/dev',
  },
})

local map = require 'utils.keymap'

map.n('<leader>L', '<cmd>Lazy<cr>', 'Lazy')
