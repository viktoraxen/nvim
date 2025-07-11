return {
    'goolord/alpha-nvim',
    config = function()
        local alpha = require 'alpha'
        local dashboard = require 'alpha.themes.dashboard'
        local map = require('utils.keymap')

        map.ln('A', '<cmd>Alpha<cr>', 'Alpha')

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
            -- vim.cmd 'e init.lua'
            -- vim.cmd 'lua Snacks.picker.files()'
        end

        dashboard.section.buttons.val = {
            dashboard.button('n', '  New file', ':ene <BAR> startinsert <CR>'),
            dashboard.button('f', '  Find files', ':lua Snacks.picker.files()<CR>'),
            dashboard.button('e', '  Explorer', ':Neotree position=current<cr>'),
            dashboard.button('p', '  Projects', ':lua Snacks.picker.projects()<CR>'),
            dashboard.button('i', '  Plugins', ':Lazy<CR>'),
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
