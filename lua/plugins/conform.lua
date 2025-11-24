return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  opts = {
    format_on_save = {
      timeout_ms = 3000,
      lsp_fallback = true,
    },
    formatters_by_ft = {
      html = { 'prettier' },
      javascriptreact = { 'prettier' },
      json = { 'prettier' },
      lua = { 'stylua' },
    },
    formatters = {
      stylua = {
        -- This function runs every time formatting is triggered
        prepend_args = function(self, ctx)
          return {
            '--indent-width',
            tostring(vim.api.nvim_get_option_value('shiftwidth', { buf = ctx.buf })),
            '--indent-type',
            vim.api.nvim_get_option_value('expandtab', { buf = ctx.buf }) and 'Spaces' or 'Tabs',
          }
        end,
      },
    },
  },
}
