return {
  'folke/tokyonight.nvim',
  priority = 1000,
  config = function()
    -- Function to apply highlights for tokyonight
    local function apply_tokyonight_highlights(scheme)
      local colors = require('tokyonight.colors').setup { style = scheme }
      vim.api.nvim_set_hl(0, 'NormalFloat', { fg = colors.fg, bg = colors.bg })
      vim.api.nvim_set_hl(0, 'FloatBorder', { fg = colors.fg, bg = colors.bg })
      vim.api.nvim_set_hl(0, 'FloatTitle', { fg = '#27a1b9', bg = colors.bg })
      vim.api.nvim_set_hl(0, 'FloatFooter', { fg = '#27a1b9', bg = colors.bg })

      vim.api.nvim_set_hl(0, 'NeoTreeNormal', { fg = colors.fg, bg = colors.bg }) -- Use a darker color for the bg
      vim.api.nvim_set_hl(0, 'NeoTreeNormalNC', { fg = colors.fg, bg = colors.bg }) -- Use a darker color for the bg

      vim.api.nvim_set_hl(0, 'TelescopeBorder', { fg = colors.fg, bg = colors.bg })
      vim.api.nvim_set_hl(0, 'TelescopeNormal', { fg = colors.fg, bg = colors.bg })
      vim.api.nvim_set_hl(0, 'TelescopePromptTitle', { fg = colors.fg, bg = colors.bg })
      vim.api.nvim_set_hl(0, 'TelescopePromptBorder', { fg = colors.fg, bg = colors.bg })

      vim.api.nvim_set_hl(0, 'Pmenu', { fg = colors.fg, bg = colors.bg })
      vim.api.nvim_set_hl(0, 'PmenuSel', { fg = colors.fg, bg = colors.blue })
      vim.api.nvim_set_hl(0, 'PmenuThumb', { bg = colors.cyan })
      vim.api.nvim_set_hl(0, 'PmenuSbar', { bg = colors.bg })

      vim.api.nvim_set_hl(0, 'DapBreakpoint', { ctermbg = 0, fg = '#993939', bg = colors.bg })
      vim.api.nvim_set_hl(0, 'DapLogPoint', { ctermbg = 0, fg = '#61afef', bg = colors.bg })
      vim.api.nvim_set_hl(0, 'DapStopped', { ctermbg = 0, fg = '#98c379', bg = colors.bg })

      -- gray
      vim.api.nvim_set_hl(0, 'CmpItemAbbrDeprecated', { bg = 'NONE', strikethrough = true, fg = colors.gray })
      -- blue
      vim.api.nvim_set_hl(0, 'CmpItemAbbrMatch', { bg = 'NONE', fg = colors.blue })
      vim.api.nvim_set_hl(0, 'CmpItemAbbrMatchFuzzy', { link = 'CmpIntemAbbrMatch' })
      -- light blue
      vim.api.nvim_set_hl(0, 'CmpItemKindVariable', { bg = 'NONE', fg = colors.teal })
      vim.api.nvim_set_hl(0, 'CmpItemKindInterface', { link = 'CmpItemKindVariable' })
      vim.api.nvim_set_hl(0, 'CmpItemKindText', { link = 'CmpItemKindVariable' })
      -- pink
      vim.api.nvim_set_hl(0, 'CmpItemKindFunction', { bg = 'NONE', fg = colors.purple })
      vim.api.nvim_set_hl(0, 'CmpItemKindMethod', { link = 'CmpItemKindFunction' })
      -- front
      vim.api.nvim_set_hl(0, 'CmpItemKindKeyword', { bg = 'NONE', fg = colors.light_grey })
      vim.api.nvim_set_hl(0, 'CmpItemKindProperty', { link = 'CmpItemKindKeyword' })
      vim.api.nvim_set_hl(0, 'CmpItemKindUnit', { link = 'CmpItemKindKeyword' })

      vim.api.nvim_set_hl(0, 'CmpItemMenu', { link = 'NormalFloat' })
      vim.api.nvim_set_hl(0, 'PMenu', { link = 'NormalFloat' })
    end

    -- Apply initial highlights for the default tokyonight-night
    vim.cmd.colorscheme 'tokyonight-night'
    apply_tokyonight_highlights 'night'

    -- Autocommand to reapply highlights on colorscheme change
    vim.api.nvim_create_autocmd('ColorScheme', {
      pattern = 'tokyonight-night,tokyonight-day',
      callback = function()
        local scheme = vim.g.colors_name == 'tokyonight-night' and 'night' or 'day'
        apply_tokyonight_highlights(scheme)
      end,
    })
  end,
  -- init = function()
  --   vim.cmd.colorscheme 'tokyonight-night'
  --
  --   local colors = require 'tokyonight.colors.night'
  --
  --   vim.api.nvim_set_hl(0, 'NormalFloat', { fg = colors.fg, bg = colors.bg })
  --   -- vim.api.nvim_set_hl(0, 'FloatBorder', { fg = '#27a1b9', bg = colors.bg })
  --   vim.api.nvim_set_hl(0, 'FloatBorder', { fg = colors.fg, bg = colors.bg })
  --   vim.api.nvim_set_hl(0, 'FloatTitle', { fg = '#27a1b9', bg = colors.bg })
  --   vim.api.nvim_set_hl(0, 'FloatFooter', { fg = '#27a1b9', bg = colors.bg })
  --
  --   -- vim.api.nvim_set_hl(0, 'TelescopeBorder', { fg = '#27a1b9', bg = colors.bg })
  --   vim.api.nvim_set_hl(0, 'TelescopeBorder', { fg = colors.fg, bg = colors.bg })
  --   vim.api.nvim_set_hl(0, 'TelescopeNormal', { fg = colors.fg, bg = colors.bg })
  --   vim.api.nvim_set_hl(0, 'TelescopePromptTitle', { fg = colors.fg, bg = colors.bg })
  --   vim.api.nvim_set_hl(0, 'TelescopePromptBorder', { fg = colors.fg, bg = colors.bg })
  --
  --   vim.api.nvim_set_hl(0, 'DapBreakpoint', { ctermbg = 0, fg = '#993939', bg = colors.bg })
  --   vim.api.nvim_set_hl(0, 'DapLogPoint', { ctermbg = 0, fg = '#61afef', bg = colors.bg })
  --   vim.api.nvim_set_hl(0, 'DapStopped', { ctermbg = 0, fg = '#98c379', bg = colors.bg })
  -- end,
}

-- vim: ts=2 sts=2 sw=2 et
