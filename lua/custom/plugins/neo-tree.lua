return {
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v3.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
    's1n7ax/nvim-window-picker',
  },
  config = function()
    -- If you want icons for diagnostic errors, you'll need to define them somewhere:
    vim.fn.sign_define('DiagnosticSignError', { text = '', texthl = 'DiagnosticSignError' })
    vim.fn.sign_define('DiagnosticSignWarn', { text = '', texthl = 'DiagnosticSignWarn' })
    vim.fn.sign_define('DiagnosticSignInfo', { text = '', texthl = 'DiagnosticSignInfo' })
    vim.fn.sign_define('DiagnosticSignHint', { text = '', texthl = 'DiagnosticSignHint' })

    vim.api.nvim_set_hl(0, 'NeoTreeGitUnstaged', { fg = '#404040', italic = false })
    vim.api.nvim_set_hl(0, 'NeoTreeGitModified', { fg = '#404040', italic = false })

    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'neo-tree',
      callback = function()
        vim.opt_local.fillchars = 'eob: ' -- Removes the ~ by setting end-of-buffer character to a blank space
      end,
    })

    require('neo-tree').setup {
      window = {
        position = 'right',
        mappings = {
          ['<space>'] = { 'toggle_node', nowait = false },
          ['<cr>'] = 'open_with_window_picker',
          ['O'] = 'open',
          ['<esc>'] = 'cancel', -- close preview or floating neo-tree window
          ['-'] = 'navigate_up',
          ['P'] = { 'toggle_preview', config = { use_float = true, use_image_nvim = true } },
          ['l'] = 'focus_preview',
          ['s'] = 'split_with_window_picker',
          ['v'] = 'vsplit_with_window_picker',
          ['C'] = 'close_node',
          -- ['C'] = 'close_all_subnodes',
          ['z'] = 'close_all_nodes',
          --["Z"] = "expand_all_nodes",
          ['a'] = { 'add', config = { show_path = 'none' } },
          ['A'] = 'add_directory', -- also accepts the optional config.show_path option like "add". this also supports BASH style brace expansion.
          ['d'] = 'delete',
          ['r'] = 'rename',
          ['y'] = 'copy_to_clipboard',
          ['x'] = 'cut_to_clipboard',
          ['p'] = 'paste_from_clipboard',
          ['c'] = 'copy_to_clipboard', -- takes text input for destination, also accepts the optional config.show_path option like "add":
          ['m'] = 'move', -- takes text input for destination, also accepts the optional config.show_path option like "add".
          ['q'] = 'close_window',
          ['R'] = 'refresh',
          ['?'] = 'show_help',
          ['<'] = 'prev_source',
          ['>'] = 'next_source',
          ['i'] = 'show_file_details',
        },
      },
      git_status = {
        window = {
          mappings = {
            ['g'] = { 'show_help', nowait = false, config = { title = 'Git', prefix_key = 'g' } },
            ['gA'] = 'git_add_all',
            ['gu'] = 'git_unstage_file',
            ['ga'] = 'git_add_file',
            ['gr'] = 'git_revert_file',
            ['gc'] = 'git_commit',
            ['gp'] = 'git_push',
            ['gg'] = 'git_commit_and_push',
            ['i'] = 'show_file_details',
            ['o'] = { 'show_help', nowait = false, config = { title = 'Order by', prefix_key = 'o' } },
            ['oc'] = { 'order_by_created', nowait = false },
            ['od'] = { 'order_by_diagnostics', nowait = false },
            ['om'] = { 'order_by_modified', nowait = false },
            ['on'] = { 'order_by_name', nowait = false },
            ['os'] = { 'order_by_size', nowait = false },
            ['ot'] = { 'order_by_type', nowait = false },
          },
        },
      },
      sources = {
        'document_symbols',
        'filesystem',
        'git_status',
        'diagnostics',
      },
      popup_border_style = 'single',
      default_component_configs = {
        diagnostics = {
          symbols = {
            hint = '',
            info = '',
            warn = '',
            error = '',
          },
          highlights = {
            hint = 'DiagnosticSignHint',
            info = 'DiagnosticSignInfo',
            warn = 'DiagnosticSignWarn',
            error = 'DiagnosticSignError',
          },
        },
        renderers = {
          directory = {
            { 'indent' },
            { 'icon' },
            { 'current_filter' },
            {
              'container',
              content = {
                { 'name', zindex = 10 },
                {
                  'symlink_target',
                  zindex = 10,
                  highlight = 'NeoTreeSymbolicLinkTarget',
                },
                { 'clipboard', zindex = 10 },
                { 'diagnostics', errors_only = true, zindex = 20, align = 'right', hide_when_expanded = true },
                { 'git_status', zindex = 10, align = 'right', hide_when_expanded = true },
                { 'file_size', zindex = 10, align = 'right' },
                { 'type', zindex = 10, align = 'right' },
                { 'last_modified', zindex = 10, align = 'right' },
                { 'created', zindex = 10, align = 'right' },
              },
            },
          },
          file = {
            { 'indent' },
            { 'icon' },
            {
              'container',
              content = {
                {
                  'name',
                  zindex = 10,
                },
                {
                  'symlink_target',
                  zindex = 10,
                  highlight = 'NeoTreeSymbolicLinkTarget',
                },
                { 'clipboard', zindex = 10 },
                { 'bufnr', zindex = 10 },
                { 'modified', zindex = 20, align = 'left' },
                { 'diagnostics', zindex = 20, align = 'left' },
                { 'git_status', zindex = 10, align = 'right' },
                -- { 'file_size', zindex = 10, align = 'right' },
                -- { 'type', zindex = 10, align = 'right' },
                -- { 'last_modified', zindex = 10, align = 'right' },
                -- { 'created', zindex = 10, align = 'right' },
              },
            },
          },
          message = {
            { 'indent', with_markers = false },
            { 'name', highlight = 'NeoTreeMessage' },
          },
          terminal = {
            { 'indent' },
            { 'icon' },
            { 'name' },
            { 'bufnr' },
          },
        },
        indent = {
          indent_size = 2,
          padding = 1, -- extra padding on left hand side
          -- indent guides
          with_markers = true,
          indent_marker = '│',
          last_indent_marker = '└',
          highlight = 'NeoTreeIndentMarker',
          -- expander config, needed for nesting files
          with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
          expander_collapsed = '',
          expander_expanded = '',
          expander_highlight = 'NeoTreeExpander',
        },
        modified = {
          symbol = '󰜥',
        },
        name = {
          use_git_status_colors = false,
        },
        git_status = {
          symbols = {
            -- Change type
            added = '', -- or "✚", but this is redundant info if you use git_status_colors on the name
            modified = '', -- or "", but this is redundant info if you use git_status_colors on the name
            deleted = '', -- this can only be used in the git_status source
            renamed = '󰳞', -- this can only be used in the git_status source
            -- Status type
            untracked = '',
            ignored = '',
            unstaged = '',
            staged = '',
            conflict = '',
          },
        },
        file_size = {
          enabled = false,
        },
        type = {
          enabled = false,
        },
        last_modified = {
          enabled = false,
        },
        created = {
          enabled = false,
        },
        symlink_target = {
          enabled = false,
        },
      },
    }
  end,
}
