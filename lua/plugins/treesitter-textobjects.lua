return {
  "nvim-treesitter/nvim-treesitter-textobjects",
  branch = "main",
  init = function()
    vim.g.no_plugin_maps = true
  end,
  opts = {
    select = {
      lookahead = true,
      selection_modes = {
        ["@parameter.outer"] = "v",
        ["@function.outer"] = "V",
        ["@class.outer"] = "V",
      },
      include_surrounding_whitespace = false,
    },
  },
  config = function(_, opts)
    require("nvim-treesitter-textobjects").setup(opts)

    local select_textobject = require("nvim-treesitter-textobjects.select").select_textobject

    local function map(lhs, query, desc)
      vim.keymap.set({ "x", "o" }, lhs, function()
        select_textobject(query, "textobjects")
      end, { desc = desc })
    end

    map("af", "@function.outer", "Around function")
    map("if", "@function.inner", "Inside function")
    map("ac", "@class.outer", "Around class")
    map("ic", "@class.inner", "Inside class")
    map("aC", "@comment.outer", "Around comment")
    map("iC", "@comment.inner", "Inside comment")
    map("as", "@scope.outer", "Around scope")
    map("is", "@scope.inner", "Inside scope")
    map("al", "@loop.outer", "Around loop")
    map("il", "@loop.inner", "Inside loop")
    map("ai", "@conditional.outer", "Around conditional")
    map("ii", "@conditional.inner", "Inside conditional")
  end,
}
