return {
  "esmuellert/codediff.nvim",
  cmd = { "CodeDiff" },
  keys = {
    { "<leader>gg", ":CodeDiff<cr>", desc = "CodeDiff" },
    { "<leader>gdf", ":CodeDiff file HEAD<cr>", desc = "File - HEAD" },
    { "<leader>gdh", ":CodeDiff history<cr>", desc = "History" },
    { "<leader>gdH", ":CodeDiff history --base WORKING<cr>", desc = "History - WORKING" },
  },
  dependencies = { "MunifTanjim/nui.nvim" },
  opts = {
    explorer = {
      position = "right",
      view_mode = "tree",
      width = 33,
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
