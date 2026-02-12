return {
  "esmuellert/codediff.nvim",
  cmd = { "CodeDiff" },
  keys = {
    { "<leader>gg", ":CodeDiff<cr>", desc = "Git" },
    { "<leader>gd", ":CodeDiff file HEAD<cr>", desc = "Diff" },
    { "<leader>gD", ":CodeDiff file HEAD~1<cr>", desc = "Diff HEAD~1" },
  },
  dependencies = { "MunifTanjim/nui.nvim" },
  opts = {
    explorer = {
      position = "right",
      view_mode = "tree",
    },
    keymaps = {
      view = {
        quit = "q",
        toggle_explorer = "<leader>e",
        next_hunk = "gj",
        prev_hunk = "gk",
        next_file = "gn",
        prev_file = "gp",
        toggle_stage = "s",
      },
    },
  },
}
