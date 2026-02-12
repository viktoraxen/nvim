return {
  "williamboman/mason.nvim",
  keys = { { "<leader>M", "<cmd>Mason<cr>", desc = "Mason" } },
  cmd = { "Mason" },
  opts = {
    ensure_installed = {
      "bash-language-server",
      "beautysh",
      "clangd",
      "cmake-language-server",
      "cmakelang",
      "codelldb",
      "eslint-lsp",
      "lua-language-server",
      "markdownlint",
      "prettier",
      "pyright",
      "python-lsp-server",
      "ruff",
      "stylua",
      "tree-sitter-cli",
    },
    ui = {
      check_outdated_packages_on_open = true,
      border = "solid",
      backdrop = 100,

      width = 0.85,
      height = 0.8,
    },
  },
}
