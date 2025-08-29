return {
    'goolord/alpha-nvim',
    config = function()
        local alpha = require 'alpha'
        local dashboard = require 'alpha.themes.dashboard'
        local map = require('utils.keymap')

        map.ln('A', '<cmd>bd % | Alpha<cr>', 'Alpha')

        dashboard.section.header.val = {
            [[                               __                ]],
            [[  ___     ___    ___   __  __ /\_\    ___ ___    ]],
            [[ / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
            [[/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
            [[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
            [[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
        }

        local open_config = function()
            vim.cmd 'cd ~/.config/nvim'
            require("persistence").load()
        end

        dashboard.section.buttons.val = {
            dashboard.button('n', '  New file', ':ene<CR>'),
            dashboard.button('f', '  Find files', Snacks.picker.files),
            dashboard.button('e', '  Explorer', ':Neotree position=current<CR>'),
            dashboard.button('p', '  Projects', Snacks.picker.projects),
            dashboard.button('l', '  Plugins', ':Lazy<CR>'),
            dashboard.button('m', '󰯠  Mason', ':Mason<CR>'),
            dashboard.button('c', '󰢻  Configuration', open_config),
            dashboard.button('q', '󱎘  Quit', ':qa<CR>'),
        }

        dashboard.config.opts.noautocmd = true

        dashboard.config.layout = {
            { type = 'padding', val = 10 },
            dashboard.section.header,
            { type = 'padding', val = 7 },
            dashboard.section.buttons,
            { type = 'padding', val = 2 },
            dashboard.section.footer,
        }

        alpha.setup(dashboard.config)
    end,
}
