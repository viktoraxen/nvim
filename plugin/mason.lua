vim.schedule(function()
  vim.pack.add({ "https://github.com/williamboman/mason.nvim" })

  require("which-key").add({
    mode = { "n" },
    { "<leader>M", "<cmd>Mason<cr>", desc = "Mason" },
  })

  require("mason").setup({
    ui = {
      check_outdated_packages_on_open = true,
      border = "solid",
      backdrop = 100,

      width = 0.85,
      height = 0.8,
    },
  })
end)
