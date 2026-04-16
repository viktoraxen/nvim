vim.schedule(function()
  vim.pack.add({ "https://github.com/neovim/nvim-lspconfig" })

  vim.lsp.enable({ "lua_ls" })
  vim.lsp.enable({ "pyright" })

  vim.lsp.document_color.enable(true, nil, { style = "virtual" })

  require("which-key").add({
    mode = { "n" },

    { "gr", group = "LSP" },

    { "gra", vim.lsp.buf.code_action, desc = "Codeaction" },
    { "grc", "<cmd>Picker lsp_declarations<cr>", desc = "Declarations" },
    { "grd", "<cmd>Picker lsp_definitions<cr>", desc = "Definintions" },
    { "grI", "<cmd>Picker lsp_implementations<cr>", desc = "Implementations" },
    { "grn", vim.lsp.buf.rename, desc = "Rename" },
    { "grr", "<cmd>Picker lsp_references<cr>", desc = "References" },
    { "gri", "<cmd>Picker lsp_incoming_calls<cr>", desc = "Incoming Calls" },
    { "gro", "<cmd>Picker lsp_outgoing_calls<cr>", desc = "Outgoing Calls" },
    { "grt", "<cmd>Picker lsp_type_definitions<cr>", desc = "Type definitions" },
    { "grx", vim.lsp.buf.codelens, desc = "Codelens" },
  })
end)
