return {
  'folke/tokyonight.nvim',
  priority = 1000,
  init = function()
    vim.cmd.colorscheme 'tokyonight-night'

    vim.api.nvim_set_hl(0, 'NormalFloat', { fg = '#27a1b9', bg = '#1a1b26' })
    vim.api.nvim_set_hl(0, 'FloatBorder', { fg = '#27a1b9', bg = '#1a1b26' })
    vim.api.nvim_set_hl(0, 'FloatTitle', { fg = '#27a1b9', bg = '#1a1b26' })
    vim.api.nvim_set_hl(0, 'FloatFooter', { fg = '#27a1b9', bg = '#1a1b26' })

    vim.opt.winblend = 15
  end,
}

-- vim: ts=2 sts=2 sw=2 et
