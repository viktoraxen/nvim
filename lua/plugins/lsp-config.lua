return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    vim.lsp.enable("luals")
    vim.lsp.enable("clangd")
    vim.lsp.enable("pyright")
    vim.lsp.enable("typescript")
    vim.lsp.enable("tailwindcss")
  end,
}
