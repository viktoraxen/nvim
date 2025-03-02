return {
    'goolord/alpha-nvim',
    config = function()
        local alpha = require 'alpha'
        local dashboard = require 'alpha.themes.dashboard'

        dashboard.section.header.val = {
            [[                               __                ]],
            [[  ___     ___    ___   __  __ /\_\    ___ ___    ]],
            [[ / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
            [[/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
            [[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
            [[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
        }

        dashboard.section.buttons.val = {
            dashboard.button('n', '  New file', ':ene <BAR> startinsert <CR>'),
            dashboard.button('f', '  Find files', ':lua Snacks.picker.files()<CR>'),
            dashboard.button('p', '  Projects', ':lua Snacks.picker.projects()<CR>'),
            dashboard.button('l', '  Plugins', ':Lazy<CR>'),
            dashboard.button('c', '  Configuration', ':cd ~/.config/nvim <CR> :e init.lua <CR> lua Snacks.picker.files()'),
            dashboard.button('q', '  Quit', ':qa<CR>'),
        }

        dashboard.config.opts.noautocmd = true

        dashboard.config.layout = {
            { type = 'padding', val = 10 },
            dashboard.section.header,
            { type = 'padding', val = 2 },
            dashboard.section.buttons,
            { type = 'padding', val = 2 },
            dashboard.section.footer,
        }

        alpha.setup(dashboard.config)
    end,
}
