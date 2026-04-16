vim.schedule(function()
  vim.pack.add({
    "https://github.com/neogitorg/neogit",
    "https://github.com/nvim-lua/plenary.nvim",
    "https://github.com/esmuellert/codediff.nvim",
    "https://github.com/folke/snacks.nvim",
  })

  require("neogit").setup({
    graph_style = "unicode",
    floating = {
      relative = "editor",
      width = 0.8,
      height = 0.7,
      style = "minimal",
      border = "solid",
    },
    popup = { kind = "floating" },
  })

  require("which-key").add({
    mode = { "n" },

    { "<leader>g", group = "Git" },
    { "<leader>gG", ":Neogit<cr>", desc = "Neogit" },
    { "<leader>gP", ":Neogit push<cr>", desc = "Push" },
    { "<leader>gb", ":Neogit branch<cr>", desc = "Branch" },
    { "<leader>gc", ":Neogit commit<cr>", desc = "Commit" },
    { "<leader>gf", ":Neogit fetch<cr>", desc = "Fetch" },
    { "<leader>gl", ":Neogit log<cr>", desc = "Log" },
    { "<leader>gL", ":Neogit log<cr>", desc = "Log" },
    { "<leader>gm", ":Neogit merge<cr>", desc = "Merge" },
    { "<leader>gp", ":Neogit pull<cr>", desc = "Pull" },
    { "<leader>gr", ":Neogit reset<cr>", desc = "Reset" },
    { "<leader>gs", ":Neogit stash<cr>", desc = "Stash" },
  })
end)
