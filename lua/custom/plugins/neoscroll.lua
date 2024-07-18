return {
  'karb94/neoscroll.nvim',
  config = function()
    require('neoscroll').setup {}
    local neoscroll = require 'neoscroll'
    local keymap = {
      -- Use the "sine" easing function
      ['<C-u>'] = function()
        neoscroll.ctrl_u { duration = 50, easing = 'sine' }
      end,
      ['<C-d>'] = function()
        neoscroll.ctrl_d { duration = 50, easing = 'sine' }
      end,
      -- Use the "circular" easing function
      ['<C-b>'] = function()
        neoscroll.ctrl_b { duration = 50, easing = 'circular' }
      end,
      ['<C-f>'] = function()
        neoscroll.ctrl_f { duration = 50, easing = 'circular' }
      end,
      -- When no value is passed the `easing` option supplied in `setup()` is used
      ['<C-y>'] = function()
        neoscroll.scroll(-0.1, { move_cursor = false, duration = 50 })
      end,
      ['<C-e>'] = function()
        neoscroll.scroll(0.1, { move_cursor = false, duration = 50 })
      end,
    }
    local modes = { 'n', 'v', 'x' }
    for key, func in pairs(keymap) do
      vim.keymap.set(modes, key, func)
    end
  end,
}
