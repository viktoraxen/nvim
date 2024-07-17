return {
  'zbirenbaum/neodim',
  event = 'LspAttach',
  config = function()
    require('neodim').setup {
      refresh_delay = 75,
      alpha = 0.4,
      blend_color = '#1a1b26',
      hide = {
        underline = true,
        virtual_text = true,
        signs = false,
      },
      regex = {
        '[uU]nused',
        '[nN]ever [rR]ead',
        '[nN]ot [rR]ead',
      },
      priority = 128,
      disable = {},
    }
  end,
}
