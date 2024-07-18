return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'rcarriga/nvim-dap-ui',

    'nvim-neotest/nvim-nio',

    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',

    'mfussenegger/nvim-dap-python',
    'suketa/nvim-dap-ruby',
  },
  keys = {
    '<leader>bc',
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    require('mason-nvim-dap').setup {
      automatic_installation = true,

      handlers = {},

      ensure_installed = {
        'debugpy',
        'rdbg',
      },
    }

    dapui.setup {
      layouts = {
        {
          elements = {
            {
              id = 'scopes',
              size = 0.25,
            },
            {
              id = 'breakpoints',
              size = 0.25,
            },
            {
              id = 'stacks',
              size = 0.25,
            },
            {
              id = 'watches',
              size = 0.25,
            },
          },
          position = 'left',
          size = 40,
        },
        {
          elements = { {
            id = 'repl',
            size = 0.5,
          }, {
            id = 'console',
            size = 0.5,
          } },
          position = 'bottom',
          size = 20,
        },
      },
      icons = { expanded = '', collapsed = '', current_frame = '' },
      controls = {
        icons = {
          pause = '',
          play = '',
          step_into = '󰆹',
          step_over = '',
          step_out = '󰆸',
          step_back = '',
          run_last = '',
          terminate = '',
          disconnect = '󰈆',
        },
      },
    }

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    require('dap-python').setup 'python3'
    require('dap-ruby').setup()

    dap.configurations.ruby = {
      {
        type = 'ruby',
        request = 'attach',
        options = { source_filetype = 'ruby' },
        error_on_failure = true,
        localfs = true,
        waiting = 1000,
        random_port = true,
        name = 'Current file',
        command = 'ruby',
        args = { '-rdebug' },
        current_file = true,
      },
    }

    vim.fn.sign_define('DapBreakpoint', { text = '', texthl = 'DapBreakpoint', numhl = 'DapBreakpoint' })
    vim.fn.sign_define('DapBreakpointCondition', { text = '', texthl = 'DapBreakpoint', numhl = 'DapBreakpoint' })
    vim.fn.sign_define('DapBreakpointRejected', { text = '󰗖', texthl = 'DapBreakpoint', numhl = 'DapBreakpoint' })
    vim.fn.sign_define('DapLogPoint', { text = '󰗖', texthl = 'DapLogPoint', numhl = 'DapLogPoint' })
    vim.fn.sign_define('DapStopped', { text = '', texthl = 'DapStopped', numhl = 'DapStopped' })
  end,
}
