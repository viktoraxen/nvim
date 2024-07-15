return {
  'karb94/neoscroll.nvim',
  config = function()
    require('neoscroll').setup {
      --   mappings = { '<C-u>', '<C-d>', '<C-b>', '<C-f>', '<C-y>', '<C-e>', 'zt', 'zz', 'zb' },
      --   easing_function = 'quintic',
      -- }
      --
      -- require('neoscroll.config').set_mappings {
      --   ['<C-u>'] = { 'scroll', { '-vim.wo.scroll', 'true', '100' } },
      --   ['<C-d>'] = { 'scroll', { 'vim.wo.scroll', 'true', '100' } },
      --   ['<C-b>'] = { 'scroll', { '-vim.api.nvim_win_get_height(0)', 'true', '100' } },
      --   ['<C-f>'] = { 'scroll', { 'vim.api.nvim_win_get_height(0)', 'true', '100' } },
      --   ['<C-y>'] = { 'scroll', { '-0.10', 'false', '20' } },
      --   ['<C-e>'] = { 'scroll', { '0.10', 'false', '20' } },
      --
      --   ['zt'] = { 'zt', { '100' } },
      --   ['zz'] = { 'zz', { '100' } },
      --   ['zb'] = { 'zb', { '100' } },
    }
    local neoscroll = require 'neoscroll'
    local keymap = {
      -- Use the "sine" easing function
      ['<C-u>'] = function()
        neoscroll.ctrl_u { duration = 100, easing = 'sine' }
      end,
      ['<C-d>'] = function()
        neoscroll.ctrl_d { duration = 100, easing = 'sine' }
      end,
      -- Use the "circular" easing function
      ['<C-b>'] = function()
        neoscroll.ctrl_b { duration = 100, easing = 'circular' }
      end,
      ['<C-f>'] = function()
        neoscroll.ctrl_f { duration = 100, easing = 'circular' }
      end,
      -- When no value is passed the `easing` option supplied in `setup()` is used
      ['<C-y>'] = function()
        neoscroll.scroll(-0.1, { move_cursor = false, duration = 100 })
      end,
      ['<C-e>'] = function()
        neoscroll.scroll(0.1, { move_cursor = false, duration = 100 })
      end,
    }
    local modes = { 'n', 'v', 'x' }
    for key, func in pairs(keymap) do
      vim.keymap.set(modes, key, func)
    end
  end,
}
