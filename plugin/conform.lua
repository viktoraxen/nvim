vim.pack.add({ "https://github.com/stevearc/conform.nvim" })

require("conform").setup({
  format_on_save = { timeout_ms = 3000, lsp_fallback = true },
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "ruff_fix", "ruff_organize_imports", "ruff_format" },
  },
  formatters = {
    ruff_format = { prepend_args = { "format", "--line-length", "100" } },
    stylua = { prepend_args = { "--indent-width", "2", "--indent-type", "spaces" } },
  },
})
