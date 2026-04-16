vim.schedule(function()
  vim.pack.add({
    {
      src = "https://github.com/saghen/blink.cmp",
      version = vim.version.range("1"),
    },
    {
      src = "https://github.com/L3MON4D3/LuaSnip",
      version = vim.version.range("2"),
    },
    "https://github.com/rafamadriz/friendly-snippets",
  })

  require("luasnip.loaders.from_vscode").lazy_load()
  require("luasnip.loaders.from_snipmate").lazy_load()

  require("blink.cmp").setup({
    keymap = {
      preset = "default",
      ["<c-h>"] = { "cancel" },
      ["<c-j>"] = { "select_next" },
      ["<c-k>"] = { "select_prev" },
      ["<c-l>"] = { "select_and_accept" },
      ["<c-d>"] = { "scroll_documentation_down" },
      ["<c-u>"] = { "scroll_documentation_up" },
    },
    snippets = { preset = "luasnip" },
    completion = {
      documentation = {
        auto_show = false,
        window = { border = "solid" },
      },
      menu = { border = "none" },
    },
    sources = {
      default = { "lazydev", "lsp", "path", "snippets", "buffer" },
      providers = {
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          score_offset = 100,
        },
      },
    },
  })
end)
