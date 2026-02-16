return {
  "williamboman/mason.nvim",
  keys = { { "<leader>M", "<cmd>Mason<cr>", desc = "Mason" } },
  cmd = { "Mason" },
  opts = {
    ui = {
      check_outdated_packages_on_open = true,
      border = require("config").border,
      backdrop = 100,

      width = 0.85,
      height = 0.8,
    },
  },
}
