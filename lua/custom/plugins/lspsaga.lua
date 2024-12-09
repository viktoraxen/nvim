return {
  {
    'nvimdev/lspsaga.nvim',
    dependencies = {
      'nvim-treesitter/nvim-treesitter', -- optional
      'nvim-tree/nvim-web-devicons', -- optional
    },
    config = function()
      require('lspsaga').setup {
        definition = {
          keys = {
            edit = '<CR>',
            vsplit = 'v',
          },
        },
        lightbulb = {
          virtual_text = true,
          sign = false,
        },
        ui = {
          code_action = ' 󱐌',
          expand = '',
          collapse = '',
          scroll_up = '<C-u>',
          scroll_down = '<C-d>',
        },
      }
    end,
  },
}
