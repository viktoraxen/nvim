return {
  'folke/tokyonight.nvim',
  priority = 1000,
  init = function()
    vim.cmd.colorscheme 'tokyonight-night'

    vim.api.nvim_set_hl(0, 'NormalFloat', { fg = '#27a1b9', bg = '#1a1b26' })
    vim.api.nvim_set_hl(0, 'FloatBorder', { fg = '#27a1b9', bg = '#1a1b26' })
    vim.api.nvim_set_hl(0, 'FloatTitle', { fg = '#27a1b9', bg = '#1a1b26' })
    vim.api.nvim_set_hl(0, 'FloatFooter', { fg = '#27a1b9', bg = '#1a1b26' })

    vim.api.nvim_set_hl(0, 'TelescopeBorder', { fg = '#27a1b9', bg = '#1a1b26' })
    vim.api.nvim_set_hl(0, 'TelescopeNormal', { fg = '#c0caf5', bg = '#1a1b26' })
    vim.api.nvim_set_hl(0, 'TelescopePromptTitle', { fg = '#ff9e64', bg = '#1a1b26' })
    vim.api.nvim_set_hl(0, 'TelescopePromptBorder', { fg = '#ff9e64', bg = '#1a1b26' })

    vim.api.nvim_set_hl(0, 'DapBreakpoint', { ctermbg = 0, fg = '#993939', bg = '#1a1b26' })
    vim.api.nvim_set_hl(0, 'DapLogPoint', { ctermbg = 0, fg = '#61afef', bg = '#1a1b26' })
    vim.api.nvim_set_hl(0, 'DapStopped', { ctermbg = 0, fg = '#98c379', bg = '#1a1b26' })
  end,
}

-- vim: ts=2 sts=2 sw=2 et
