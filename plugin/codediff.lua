vim.schedule(function()
  vim.pack.add({
    "https://github.com/esmuellert/codediff.nvim",
    "https://github.com/MunifTanjim/nui.nvim",
  })

  require("codediff").setup({
    explorer = {
      position = "left",
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
  })

  require("which-key").add({
    mode = { "n" },

    { "<leader>g", group = "Git" },
    { "<leader>gg", ":CodeDiff<cr>", desc = "CodeDiff" },
    { "<leader>gdf", ":CodeDiff file HEAD<cr>", desc = "File - HEAD" },
    { "<leader>gdh", ":CodeDiff history<cr>", desc = "History" },
    { "<leader>gdH", ":CodeDiff history --base WORKING<cr>", desc = "History - WORKING" },
  })
end)
