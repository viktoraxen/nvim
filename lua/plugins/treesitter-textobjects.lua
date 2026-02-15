return {
  "nvim-treesitter/nvim-treesitter-textobjects",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    require("nvim-treesitter").setup({
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
            ["ac"] = { query = "@class.outer", desc = "Around class" },
            ["ic"] = { query = "@class.inner", desc = "Inner class" },
            ["aC"] = { query = "@comment.outer", desc = "Around comment" },
            ["iC"] = { query = "@comment.inner", desc = "Inner comment" },
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
          border = require("config").border,
          floating_preview_opts = {
            max_height = 22,
          },
          peek_definition_code = {
            ["gpd"] = "@function.outer",
            ["gpD"] = "@function.inner",
            ["gpc"] = "@class.outer",
            ["gpC"] = "@class.inner",
          },
        },
      },
    })
  end,
}
