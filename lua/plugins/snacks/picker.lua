return {
    prompt = ' ',
    sources = {},
    focus = 'input',
    layout = {
        width = 0.8,
        height = 0.8,
        border = "rounded",
        backdrop = false,
        preset = function()
            return vim.o.columns >= 120 and 'default' or 'ivy_split'
        end,
        layout = {
            backdrop = false,
        }
    },
    picker = {
        sources = {
            projects = {
                confirm = require("persistence").load
            }
        }
    },
    ui_select = true, -- replace `vim.ui.select` with the snacks picker
    win = {
        input = {
            keys = {
                ['<Esc>'] = { 'close', mode = { 'n', 'i' } },
                ['<C-c>'] = { 'cancel', mode = 'i' },
                ['<C-w>'] = { '<c-s-w>', mode = { 'i' }, expr = true, desc = 'delete word' },
                ['<CR>'] = { 'confirm', mode = { 'n', 'i' } },
                ['<Up>'] = { 'history_up', mode = { 'i', 'n' } },
                ['<Down>'] = { 'history_down', mode = { 'i', 'n' } },
                ['j'] = { 'list_down', mode = { 'n' } },
                ['k'] = { 'list_up', mode = { 'n' } },
                ['<S-CR>'] = { { 'pick_win', 'jump' }, mode = { 'n', 'i' } },
                ['<S-Tab>'] = { 'select_and_prev', mode = { 'i', 'n' } },
                ['<Tab>'] = { 'select_and_next', mode = { 'i', 'n' } },

                ['<c-d>'] = { 'preview_scroll_down', mode = { 'i', 'n' } },
                ['<c-u>'] = { 'preview_scroll_up', mode = { 'i', 'n' } },
                ['<c-l>'] = { 'focus_preview', mode = { 'n', 'i' } },
                ['<c-k>'] = { 'list_up', mode = { 'i', 'n' } },
                ['<c-j>'] = { 'list_down', mode = { 'i', 'n' } },
                ['<C-h>'] = { '<c-s-w>', mode = { 'i' }, expr = true, desc = 'delete word' },

                ['<c-s>'] = { 'edit_split', mode = { 'i', 'n' } },
                ['<c-v>'] = { 'edit_vsplit', mode = { 'i', 'n' } },
                ['q'] = { 'close', mode = { 'n' } },
            },
        },
        list = {
            keys = {
                ['i'] = 'focus_input',
                ['j'] = 'list_down',
                ['k'] = 'list_up',
                ['q'] = 'close',
            },
        },
        preview = {
            keys = {
                ['<Esc>'] = 'cancel',
                ['q'] = 'close',
                ['i'] = 'focus_input',
                ['<c-h>'] = 'focus_input',
                ['<c-l>'] = 'confirm',
            },
        },
    },
    ---@class snacks.picker.icons
    icons = {
        git = {
            enabled = true,
            commit = '󰜘 ',
            staged = '',
            added = '',
            deleted = '',
            ignored = ' ',
            modified = '',
            renamed = '󰳞',
            unmerged = ' ',
            untracked = '',
        },
        diagnostics = {
            Error = ' ',
            Warn = ' ',
            Hint = ' ',
            Info = ' ',
        },
    },
}
