return {
  'saghen/blink.cmp',
  dependencies = {
    'rafamadriz/friendly-snippets',
    { 'L3MON4D3/LuaSnip', version = 'v2.*' },
  },
  version = '1.*',
  opts_extend = { 'sources.default' },
  opts = {
    keymap = {
      preset = 'default',
      ['<c-h>'] = { 'cancel' },
      ['<c-j>'] = { 'select_next' },
      ['<c-k>'] = { 'select_prev' },
      ['<c-l>'] = { 'select_and_accept' },
      ['<c-o>'] = { 'show_documentation' },
      ['<c-d>'] = { 'scroll_documentation_down' },
      ['<c-u>'] = { 'scroll_documentation_up' },
    },

    snippets = { preset = 'luasnip' },

    completion = {
      documentation = {
        auto_show = false,
        window = {
          border = 'solid',
          winblend = 5,
        },
      },
      menu = {
        winblend = 5,
        border = 'none',
      },
    },

    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
    },
  },
  event = 'InsertEnter',
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  config = function(_, opts)
    vim.api.nvim_create_autocmd('User', {
      pattern = 'BlinkCmpMenuOpen',
      callback = function()
        vim.g.snacks_animate = false
      end,
    })

    vim.api.nvim_create_autocmd('User', {
      pattern = 'BlinkCmpMenuClose',
      callback = function()
        vim.g.snacks_animate = true
      end,
    })

    require('luasnip.loaders.from_vscode').lazy_load()

    require('luasnip').filetype_extend('typescriptreact', { 'html' })
    require('luasnip').filetype_extend('typescript', { 'html' })
    require('luasnip').filetype_extend('javascriptreact', { 'html' })
    require('luasnip').filetype_extend('javascript', { 'html' })

    require('blink.cmp').setup(opts)
  end,
}
