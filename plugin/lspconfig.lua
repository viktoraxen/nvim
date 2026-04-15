vim.pack.add({ "https://github.com/neovim/nvim-lspconfig" })

vim.lsp.enable({ "lua_ls" })
vim.lsp.enable({ "pyright" })

vim.lsp.document_color.enable(true, nil, { style = "virtual" })
