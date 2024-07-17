return {
  'code-biscuits/nvim-biscuits',
  config = function()
    require('nvim-biscuits').setup {
      default_config = {
        prefix_string = ' ',
      },
      -- trim_by_words = true,
      -- max_length = 1,
      cursor_line_only = true,
    }
  end,
}
