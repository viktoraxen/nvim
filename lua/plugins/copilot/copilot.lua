return {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'VeryLazy',
    config = function()
        require('copilot').setup {
            -- panel = { enabled = false },
            -- suggestion = { enabled = false },
            panel = {
                auto_refresh = true,
                keymap = {
                    jump_prev = '<M-k>',
                    jump_next = '<M-j>',
                },
            },
            suggestion = {
                auto_trigger = true,
                keymap = {
                    next = '<M-n>',
                    prev = '<M-p>',
                    dismiss = '<M-d>',
                },
            },
        }

        local map = require('utils.keymap')

        map.l_group('p', 'CoPilot')

        map.ln('pc', '<cmd>Copilot toggle<cr>', 'Toggle')
        map.ln('pd', '<cmd>Copilot disable<cr>', 'Disable')
        map.ln('pe', '<cmd>Copilot enable<cr>', 'Enable')
    end,
}
