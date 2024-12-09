return {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    'ray-x/lsp_signature.nvim',
  },
  config = function()
    require('lualine').setup {
      options = {
        icons_enabled = true,
        theme = 'auto',
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = {
          statusline = { 'alpha' },
          winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = true,
        refresh = {
          statusline = 1000,
          tabline = 1000,
          winbar = 1000,
        },
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = {
          {
            'b:gitsigns_head',
            icon = '',
          },
          'diff',
        },
        lualine_c = {
          {
            'filename',
            path = 0,
            symbols = {
              modified = '~',
              readonly = '-',
            },
          },
          'diagnostics',
          -- {
          --   color = { fg = '#7aa2f7' },
          --   function()
          --     if not pcall(require, 'lsp_signature') then
          --       return
          --     end
          --     local sig = require('lsp_signature').status_line(width)
          --     if sig.label == '' then
          --       return ''
          --     end
          --     return sig.label .. '  ' .. sig.hint
          --   end,
          -- },
        },
        lualine_x = { 'copilot' },
        lualine_y = { 'fileformat', 'filetype' },
        lualine_z = { 'progress', 'location' },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      winbar = {},
      inactive_winbar = {},
      extensions = {},
    }
  end,
}
