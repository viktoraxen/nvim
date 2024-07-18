return {
  'folke/trouble.nvim',
  opts = {}, -- for default options, refer to the configuration section for custom setup.
  dependencies = {
    'artemave/workspace-diagnostics.nvim',
  },
  cmd = 'Trouble',
  keys = {
    {
      '<leader>dd',
      '<cmd>Trouble diagnostics toggle<cr>',
      desc = 'Workspace Diagnostics',
    },
    {
      '<leader>db',
      '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
      desc = 'Buffer Diagnostics ',
    },
    {
      '<leader>dl',
      '<cmd>Trouble loclist toggle<cr>',
      desc = 'Location List ',
    },
    {
      '<leader>dq',
      '<cmd>Trouble qflist toggle<sr>',
      desc = 'Quickfix List',
    },
  },
  config = function()
    require('lazy').setup { 'artemave/workspace-diagnostics.nvim' }
    require('trouble').setup {
      auto_fold = true,
      focus = true,
      use_lsp_diagnostic_signs = true,
    }
  end,
}
