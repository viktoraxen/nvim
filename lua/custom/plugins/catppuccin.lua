return {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000,
  config = function()
    require('catppuccin').setup {
      flavour = 'mocha',
      -- dim_inactive = {
      --   enabled = true,
      --   shade = 'dark'
      --   percentage = 0.25,
      -- }
    }
  end,
}
