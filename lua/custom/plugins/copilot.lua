return {
  'zbirenbaum/copilot.lua',
  cmd = 'Copilot',
  event = 'InsertEnter',
  config = function()
    require('copilot').setup {
      -- panel = { enabled = false },
      -- suggestion = { enabled = false },
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
}
