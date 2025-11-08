return {
    'stevearc/conform.nvim',
    opts = {
        format_on_save = {
            timeout_ms = 3000,
            lsp_fallback = true,
        },
        formatters_by_ft = {
            html = { "prettier" },
            javascriptreact = { "prettier" },
            json = { "prettier" },
        }
    }
}
