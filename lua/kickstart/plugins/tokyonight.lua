return {
  'folke/tokyonight.nvim',
  priority = 1000,
  config = function()
    -- Function to apply highlights for tokyonight
    local function apply_tokyonight_highlights(scheme)
      require('tokyonight').setup {
        style = 'day',
        on_colors = function(colors)
          colors.bg = '#fdf6e3'
          colors.bg_dark = '#ebe4d3'
        end,
      }
      local colors = require('tokyonight.colors').setup { style = scheme }

      vim.api.nvim_set_hl(0, 'NormalFloat', { fg = colors.fg, bg = colors.bg })
      vim.api.nvim_set_hl(0, 'FloatBorder', { fg = colors.fg, bg = colors.bg })
      vim.api.nvim_set_hl(0, 'FloatTitle', { fg = colors.fg, bg = colors.bg })
      vim.api.nvim_set_hl(0, 'FloatFooter', { fg = colors.fg, bg = colors.bg })

      vim.api.nvim_set_hl(0, 'NeoTreeNormal', { fg = colors.fg_sidebar, bg = colors.bg_dark }) -- Use a darker color for the bg
      vim.api.nvim_set_hl(0, 'NeoTreeNormalNC', { fg = colors.fg_sidebar, bg = colors.bg_dark }) -- Use a darker color for the bg

      vim.api.nvim_set_hl(0, 'TelescopeBorder', { fg = colors.fg, bg = colors.bg })
      vim.api.nvim_set_hl(0, 'TelescopeNormal', { fg = colors.fg, bg = colors.bg })
      vim.api.nvim_set_hl(0, 'TelescopePromptTitle', { fg = colors.fg, bg = colors.bg })
      vim.api.nvim_set_hl(0, 'TelescopePromptBorder', { fg = colors.fg, bg = colors.bg })

      vim.api.nvim_set_hl(0, 'Pmenu', { fg = colors.fg, bg = colors.bg })
      vim.api.nvim_set_hl(0, 'PmenuSel', { fg = colors.fg, bg = colors.blue })
      vim.api.nvim_set_hl(0, 'PmenuThumb', { bg = colors.cyan })
      vim.api.nvim_set_hl(0, 'PmenuSbar', { bg = colors.bg })

      vim.api.nvim_set_hl(0, 'DapBreakpoint', { ctermbg = 0, fg = colors.red, bg = colors.bg })
      vim.api.nvim_set_hl(0, 'DapLogPoint', { ctermbg = 0, fg = colors.teal, bg = colors.bg })
      vim.api.nvim_set_hl(0, 'DapStopped', { ctermbg = 0, fg = colors.green, bg = colors.bg })

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
}

-- vim: ts=2 sts=2 sw=2 et
--   on_highlights = function(hl, colors)
--     hl.BufferCurrent.bg = '#fdf6e3'
--     hl.BufferCurrentERROR.bg = '#fdf6e3'
--     hl.BufferCurrentHINT.bg = '#fdf6e3'
--     hl.BufferCurrentINFO.bg = '#fdf6e3'
--     hl.BufferCurrentWARN.bg = '#fdf6e3'
--     hl.BufferCurrentIndex.bg = '#fdf6e3'
--     hl.BufferCurrentMod.bg = '#fdf6e3'
--     hl.BufferCurrentSign.fg = '#fdf6e3'
--     hl.BufferCurrentSign.bg = '#fdf6e3'
--     hl.BufferCurrentTarget.bg = '#fdf6e3'
--     hl.BufferInactiveSign.fg = '#fdf6e3'
--     hl.Cursor.fg = '#fdf6e3'
--     hl.CursorIM.fg = '#fdf6e3'
--     hl.EndOfBuffer.fg = '#fdf6e3'
--     hl.FoldColumn.bg = '#fdf6e3'
--     hl.MiniStarterItem.bg = '#fdf6e3'
--     hl.NeoTreeTabSeparatorInactive.fg = '#fdf6e3'
--     hl.Normal.bg = '#fdf6e3'
--     hl.NormalNC.bg = '#fdf6e3'
--     hl.NotifyBackground.bg = '#fdf6e3'
--     hl.NotifyDEBUGBody.bg = '#fdf6e3'
--     hl.NotifyDEBUGBorder.bg = '#fdf6e3'
--     hl.NotifyERRORBody.bg = '#fdf6e3'
--     hl.NotifyERRORBorder.bg = '#fdf6e3'
--     hl.NotifyINFOBody.bg = '#fdf6e3'
--     hl.NotifyINFOBorder.bg = '#fdf6e3'
--     hl.NotifyTRACEBody.bg = '#fdf6e3'
--     hl.NotifyTRACEBorder.bg = '#fdf6e3'
--     hl.NotifyWARNBody.bg = '#fdf6e3'
--     hl.NotifyWARNBorder.bg = '#fdf6e3'
--     hl.SignColumn.bg = '#fdf6e3'
--     hl.Todo.bg = '#fdf6e3'
--     hl.lCursor.bg = '#fdf6e3'
--   end,
-- }
