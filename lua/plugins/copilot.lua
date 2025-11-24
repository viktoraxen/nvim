return {
  'zbirenbaum/copilot.lua',
  cmd = 'Copilot',
  config = function()
    require('copilot').setup {
      panel = {
        auto_refresh = true,
        keymap = {
          jump_prev = '<M-k>',
          jump_next = '<M-j>',
        },
      },
      suggestion = {
        auto_trigger = true,
        keymap = {
          next = '<M-n>',
          prev = '<M-p>',
          dismiss = '<M-d>',
        },
      },
    }
  end,
  keys = {
    { '<leader>pe', ':Copilot enable<cr>', desc = 'Enable CoPilot' },
    { '<leader>pd', ':Copilot disable<cr>', desc = 'Disable CoPilot' },
    { '<leader>pp', ':Copilot toggle<cr>', desc = 'Toggle CoPilot' },
  },
}
