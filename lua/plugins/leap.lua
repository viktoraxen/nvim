return {
  'ggandor/leap.nvim',
  config = function()
    local map = require 'utils.keymap'

    map.n('s', '<Plug>(leap)', 'Leap')
    map.v('s', '<Plug>(leap)', 'Leap')
    map.o('s', '<Plug>(leap)', 'Leap')
  end,
}
