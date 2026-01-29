return {
  "esmuellert/codediff.nvim",
  cmd = { "CodeDiff" },
  keys = { { "<leader>gd", ":CodeDiff file HEAD<cr>", desc = "Diff current file" } },
  dependencies = { "MunifTanjim/nui.nvim" },
}
