return {
  'numToStr/FTerm.nvim',
  config = function()
    require('FTerm').setup {
      blend = 10,
      dimensions = {
        height = 0.95,
        width = 0.95,
        x = 0.5,
        y = 0.5,
      },
    }
  end,
}
