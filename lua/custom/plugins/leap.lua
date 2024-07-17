return {
  'ggandor/leap.nvim',
  config = function()
    -- require('leap').create_default_mappings()
    vim.keymap.set('n', 't', '<Plug>(leap)')
    vim.keymap.set('n', 'T', '<Plug>(leap-from-window)')
    vim.keymap.set({ 'x', 'o' }, 't', '<Plug>(leap-forward)')
    vim.keymap.set({ 'x', 'o' }, 'T', '<Plug>(leap-backward)')
    -- Define equivalence classes for brackets and quotes, in addition to
    -- the default whitespace group.
    require('leap').opts.equivalence_classes = { ' \t\r\n', '([{', ')]}', '\'"`' }

    -- Override some old defaults - use backspace instead of tab (see issue #165).
    require('leap').opts.special_keys.prev_target = '<backspace>'
    require('leap').opts.special_keys.prev_group = '<backspace>'

    -- Use the traversal keys to repeat the previous motion without explicitly
    -- invoking Leap.
    require('leap.user').set_repeat_keys('<enter>', '<backspace>')
  end,
}
