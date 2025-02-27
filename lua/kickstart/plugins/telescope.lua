return {
  {
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      'nvim-telescope/telescope-ui-select.nvim',
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      local telescope = require 'telescope'
      local actions = require 'telescope.actions'

      local preview_horizontal = function()
        return {
          preview = true,
          layout_strategy = 'horizontal',
          sorting_strategy = 'ascending',
          -- border = 'none',
          layout_config = {
            width = 0.75,
            height = 0.8,
          },
        }
      end

      local preview_vertical = function()
        return {
          preview = true,
          layout_strategy = 'vertical',
          sorting_strategy = 'ascending',
          layout_config = {
            width = 0.5,
            height = 0.5,
            vertical = {
              preview_height = 0.2,
            },
          },
        }
      end

      telescope.setup {
        defaults = {
          winblend = 10,
          prompt_prefix = '  ',
          selection_caret = ' ',
          path_display = { 'smart' },
          results_title = false,

          sorting_strategy = 'ascending',
          layout_strategy = 'vertical',
          layout_config = {
            width = 0.5,
            height = 0.3,
            vertical = {
              prompt_position = 'top',
              preview_height = 0.25,
            },
            horizontal = {
              prompt_position = 'top',
              preview_width = 0.55,
            },
          },
          preview = false,
          mappings = {
            i = {
              ['<C-j>'] = actions.move_selection_next,
              ['<C-k>'] = actions.move_selection_previous,
              ['<C-h>'] = actions.close,
              ['<C-s>'] = actions.select_horizontal,
              ['<C-l>'] = actions.select_default,
            },
          },
        },

        pickers = {
          find_files = preview_horizontal(),
          lsp_references = preview_horizontal(),
          lsp_document_symbols = preview_horizontal(),
          lsp_dynamic_workspace_symbols = preview_horizontal(),
          diagnostics = preview_horizontal(),
          live_grep = preview_horizontal(),
          symbols = preview_horizontal(),
          grep_string = preview_horizontal(),
          highlights = preview_vertical(),
        },
      }

      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')
      pcall(require('telescope').load_extension, 'project')
      -- pcall(require('telescope').load_extension, 'lsp-handlers')

      telescope.setup {
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
          repo = {
            list = {
              fd_opts = {
                '--no-ignore-vcs',
              },
              search_dirs = {
                '~/dev',
              },
            },
          },
        },
      }
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
