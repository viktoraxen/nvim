return {
  "nvim-treesitter/nvim-treesitter-textobjects",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    require("nvim-treesitter.configs").setup({
      modules = {},
      sync_install = false,
      auto_install = true,
      ignore_install = {},
      textobjects = {
        select = {
          enable = true,
          keymaps = {
            ["af"] = { query = "@function.outer", desc = "Around function" },
            ["if"] = { query = "@function.inner", desc = "Inner function" },
            ["aC"] = { query = "@class.outer", desc = "Around class" },
            ["iC"] = { query = "@class.inner", desc = "Inner class" },
            ["ac"] = { query = "@comment.outer", desc = "Around comment" },
            ["ic"] = { query = "@comment.inner", desc = "Inner comment" },
            ["as"] = { query = "@scope.outer", desc = "Around scope" },
            ["is"] = { query = "@scope.inner", desc = "Inner scope" },
            ["al"] = { query = "@loop.outer", desc = "Around loop" },
            ["il"] = { query = "@loop.inner", desc = "Inner loop" },
            ["ai"] = { query = "@conditional.outer", desc = "Around conditional" },
            ["ii"] = { query = "@conditional.inner", desc = "Inner conditional" },
          },
        },
        include_surrounding_whitespace = true,
        lsp_interop = {
          enable = true,
          border = "single",
          floating_preview_opts = {
            max_height = 22,
          },
          peek_definition_code = {
            ["<leader>pf"] = "@function.outer",
            ["<leader>pc"] = "@class.outer",
          },
        },
      },
    })
  end,
}
