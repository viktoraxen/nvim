return {
  'akinsho/toggleterm.nvim',
  config = function()
    require('toggleterm').setup {
      size = function()
        return math.floor(vim.o.columns * 0.5)
      end,
      hide_numbers = true,
      shade_filetypes = {},
      shade_terminals = true,
      shading_factor = 2,
      start_in_insert = true,
      insert_mappings = true,
      persist_size = true, -- remember window size
      direction = 'vertical', -- default layout
      close_on_exit = false, -- don't close the terminal buffer when the terminal process exits
      shell = vim.o.shell,
      float_opts = {
        border = 'single',
        winblend = 15,
        width = function()
          return math.floor(vim.o.columns * 0.9)
        end,
        height = function()
          return math.floor(vim.o.lines * 0.8)
        end,
        highlights = {
          border = 'FloatBorder',
          background = 'Normal',
        },
      },
    }
  end,
}
