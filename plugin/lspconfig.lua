vim.pack.add({ "https://github.com/neovim/nvim-lspconfig" })

vim.lsp.enable({ "lua_ls" })
vim.lsp.enable({ "pyright" })

vim.lsp.document_color.enable(true, nil, { style = "virtual" })

require("which-key").add({
  mode = { "n" },

  { "gr", group = "LSP" },

  { "gra", vim.lsp.buf.code_action, desc = "Codeaction" },
  { "grc", Snacks.picker.lsp_declarations, desc = "Declarations" },
  { "grd", Snacks.picker.lsp_definitions, desc = "Definintions" },
  { "gri", Snacks.picker.lsp_implementations, desc = "Implementations" },
  { "grn", vim.lsp.buf.rename, desc = "Rename" },
  { "grr", Snacks.picker.lsp_references, desc = "References" },
  { "grt", Snacks.picker.lsp_type_definitions, desc = "Type definitions" },
  { "grx", vim.lsp.buf.codelens, desc = "Codelens" },
})
