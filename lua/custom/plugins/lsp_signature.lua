return {
  'ray-x/lsp_signature.nvim',
  event = 'VeryLazy',
  opts = {},
  config = function()
    require('lsp_signature').setup {
      hint_prefix = ' ',
      hint_enable = false,
      handler_opts = {
        border = 'single',
      },
      transparency = 15,
    }
  end,
}
