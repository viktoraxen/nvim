local layouts = require('plugins.snacks.layouts')

return {
    prompt = ' ',
    layout = function(_)
        return vim.o.columns >= 120 and layouts.wide or layouts.narrow
    end,
    matcher = { frecency = true },
    ui_select = true,
    -- layouts = {
    --     -- does not work, layout seems to be hardcoded for select
    --     select = {
    --         -- reverse = true, -- this works, so the config is used, but not the layout
    --         layout = layouts.vscode,
    --         config = function(_)
    --             return layouts.vscode
    --         end,
    --     },
    -- },
    previewers = {
        diff = {
            builtin = false,
            cmd = {
                "delta",
                "--line-numbers",
                "--diff-so-fancy",
                "--file-style='omit'",
                "--hunk-header-style='omit'",
            }
        },
        git = {
            builtin = false,
            args = {
                "-c", "core.pager=delta --line-numbers  --diff-so-fancy --file-style='omit' --hunk-header-style='omit'",
            }
        },
    },
    win = {
        input = {
            keys = {
                ['<esc>'] = { 'close', mode = { 'n', 'i' } },
                ['<c-c>'] = { 'cancel', mode = { 'i', 'n' } },
                ['<c-w>'] = { '<c-s-w>', mode = { 'i' }, expr = true, desc = 'delete word' },
                ['<cr>'] = { 'confirm', mode = { 'n', 'i' } },
                ['j'] = { 'list_down', mode = { 'n' } },
                ['k'] = { 'list_up', mode = { 'n' } },

                ['<c-d>'] = { 'preview_scroll_down', mode = { 'i', 'n' } },
                ['<c-u>'] = { 'preview_scroll_up', mode = { 'i', 'n' } },
                ['<c-l>'] = { 'focus_preview', mode = { 'n', 'i' } },
                ['<c-k>'] = { 'list_up', mode = { 'i', 'n' } },
                ['<c-j>'] = { 'list_down', mode = { 'i', 'n' } },

                ['<c-s>'] = { 'edit_split', mode = { 'i', 'n' } },
                ['<c-v>'] = { 'edit_vsplit', mode = { 'i', 'n' } },
                ['q'] = { 'close', mode = { 'n' } },
            },
        },
        list = {
            keys = {
                -- ['i'] = 'focus_input',
                ['<c-k>'] = 'focus_input',
                -- ['j'] = 'list_down',
                -- ['k'] = 'list_up',
                ['<c-l>'] = 'focus_preview',
                ['q'] = 'close',
                ['<c-c>'] = 'close',
            },
        },
        preview = {
            keys = {
                ['<esc>'] = 'cancel',
                ['q'] = 'close',
                ['<c-c>'] = 'close',
                ['i'] = 'focus_input',
                ['<c-h>'] = 'focus_input',
                ['<c-l>'] = 'confirm',
            },
        },
    },
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
            error = ' ',
            warn = ' ',
            hint = ' ',
            info = ' ',
        },
    },
}
