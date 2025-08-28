local solid_open = false

local function neo_tree()
    if vim.bo.filetype == 'neo-tree' then
        vim.cmd('Neotree close')
    elseif solid_open then
        vim.cmd('Neotree focus')
    else
        vim.cmd('Neotree right')
    end
end

local function neo_tree_solid()
    if vim.bo.filetype == 'neo-tree' then
        vim.cmd('Neotree close')
    else
        vim.cmd('Neotree right')
        solid_open = true
    end
end

return {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
        'MunifTanjim/nui.nvim',
        's1n7ax/nvim-window-picker',
        'mrbjarksen/neo-tree-diagnostics.nvim',
    },
    cmd = {
        'Neotree',
    },
    keys = {
        { '<leader>e', neo_tree,       desc = 'Neotree' },
        { '<leader>E', neo_tree_solid, desc = 'Neotree (Persistent)' },
    },
    config = function()
        vim.api.nvim_create_autocmd('FileType', {
            desc = 'Disable fillchars for NeoTree',
            pattern = 'neo-tree',
            callback = function()
                vim.opt_local.fillchars = 'eob: ' -- Removes the ~ by setting end-of-buffer character to a blank space
            end,
        })

        local function on_move(data)
            Snacks.rename.on_rename_file(data.source, data.destination)
        end
        local events = require("neo-tree.events")

        require('neo-tree').setup {
            popup_border_style = "",
            event_handlers = {
                { event = events.FILE_MOVED,   handler = on_move },
                { event = events.FILE_RENAMED, handler = on_move },
                {
                    event = "neo_tree_window_after_close",
                    handler = function(_)
                        solid_open = false
                    end
                },
                {
                    event = "file_opened",
                    handler = function(_)
                        if not solid_open then
                            require("neo-tree.command").execute({ action = "close" })
                        end
                    end
                },
                {
                    event = "neo_tree_buffer_leave",
                    handler = function(_)
                        if not solid_open then
                            require("neo-tree.command").execute({ action = "close" })
                        end
                    end
                }
            },
            filesystem = {
                use_trash = true,
                filtered_items = {
                    show_hidden_count = false,
                    hide_dotfiles = false
                }
            },
            window = {
                width = 43,
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
                    ['z'] = 'close_all_nodes',
                    ['a'] = { 'add', config = { show_path = 'none' } },
                    ['A'] = 'add_directory',
                    ['d'] = 'delete',
                    ['r'] = 'rename',
                    ['y'] = 'copy_to_clipboard',
                    ['x'] = 'cut_to_clipboard',
                    ['p'] = 'paste_from_clipboard',
                    ['c'] = 'copy_to_clipboard',
                    ['m'] = 'move',
                    ['q'] = 'close_window',
                    ['R'] = 'refresh',
                    ['?'] = 'show_help',
                    ['K'] = 'show_file_details',
                },
            },
            sources = {
                'filesystem',
            },
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
                                { 'name',           zindex = 10 },
                                { 'symlink_target', zindex = 10, highlight = 'NeoTreeSymbolicLinkTarget', },
                                { 'clipboard',      zindex = 10 },
                                -- { 'diagnostics',    errors_only = true, zindex = 20,                             align = 'right',          hide_when_expanded = true },
                                { 'git_status',     zindex = 10, align = 'right',                         hide_when_expanded = true },
                            },
                        },
                    },
                    file = {
                        { 'indent' },
                        { 'icon' },
                        {
                            'container',
                            content = {
                                { 'name',           zindex = 10, },
                                { 'symlink_target', zindex = 10, highlight = 'NeoTreeSymbolicLinkTarget', },
                                { 'clipboard',      zindex = 10 },
                                { 'diagnostics',    zindex = 20, align = 'left' },
                                { 'git_status',     zindex = 10, align = 'right' },
                            },
                        },
                    },
                },
                indent = {
                    indent_size        = 2,
                    padding            = 1, -- extra padding on left hand side
                    -- indent guides
                    with_markers       = true,
                    indent_marker      = '│',
                    last_indent_marker = '└',
                    highlight          = 'NeoTreeIndentMarker',
                    -- expander config, needed for nesting files
                    with_expanders     = nil, -- if nil and file nesting is enabled, will enable expanders
                    expander_collapsed = '',
                    expander_expanded  = '',
                    expander_highlight = 'NeoTreeExpander',
                },
                modified = {
                    symbol = '󰜥',
                    highlight = 'Comment',
                },
                name = {
                    use_git_status_colors = false,
                },
                git_status = {
                    symbols = {
                        -- Change type
                        added     = '',
                        modified  = '',
                        deleted   = '',
                        renamed   = '󰳞',
                        -- Status type
                        untracked = '',
                        ignored   = '',
                        unstaged  = '',
                        staged    = '',
                        conflict  = '',
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
                    enabled = true,
                },
            },
        }
    end,
}
