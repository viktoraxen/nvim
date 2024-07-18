return {
  'folke/tokyonight.nvim',
  priority = 1000,
  init = function()
    vim.cmd.colorscheme 'tokyonight-night'

    local colors = require 'tokyonight.colors.night'

    vim.api.nvim_set_hl(0, 'NormalFloat', { fg = colors.fg, bg = colors.bg })
    -- vim.api.nvim_set_hl(0, 'FloatBorder', { fg = '#27a1b9', bg = colors.bg })
    vim.api.nvim_set_hl(0, 'FloatBorder', { fg = colors.fg, bg = colors.bg })
    vim.api.nvim_set_hl(0, 'FloatTitle', { fg = '#27a1b9', bg = colors.bg })
    vim.api.nvim_set_hl(0, 'FloatFooter', { fg = '#27a1b9', bg = colors.bg })

    -- vim.api.nvim_set_hl(0, 'TelescopeBorder', { fg = '#27a1b9', bg = colors.bg })
    vim.api.nvim_set_hl(0, 'TelescopeBorder', { fg = colors.fg, bg = colors.bg })
    vim.api.nvim_set_hl(0, 'TelescopeNormal', { fg = colors.fg, bg = colors.bg })
    vim.api.nvim_set_hl(0, 'TelescopePromptTitle', { fg = '#27a1b9', bg = colors.bg })
    vim.api.nvim_set_hl(0, 'TelescopePromptBorder', { fg = colors.fg, bg = colors.bg })

    vim.api.nvim_set_hl(0, 'DapBreakpoint', { ctermbg = 0, fg = '#993939', bg = colors.bg })
    vim.api.nvim_set_hl(0, 'DapLogPoint', { ctermbg = 0, fg = '#61afef', bg = colors.bg })
    vim.api.nvim_set_hl(0, 'DapStopped', { ctermbg = 0, fg = '#98c379', bg = colors.bg })
  end,
}

-- vim: ts=2 sts=2 sw=2 et
