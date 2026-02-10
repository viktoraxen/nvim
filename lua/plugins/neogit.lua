return {
  "NeogitOrg/neogit",
  keys = {
    { "<leader>gG", "<cmd>Neogit<cr>", desc = "Neogit" },
    { "<leader>gb", "<cmd>Neogit branch<cr>", desc = "Branch" },
    { "<leader>gc", "<cmd>Neogit commit<cr>", desc = "Commit" },
    { "<leader>gf", "<cmd>Neogit fetch<cr>", desc = "Fetch" },
    { "<leader>gl", "<cmd>Neogit log<cr>", desc = "Log" },
    { "<leader>gm", "<cmd>Neogit merge<cr>", desc = "Merge" },
    { "<leader>gp", "<cmd>Neogit pull<cr>", desc = "Pull" },
    { "<leader>gP", "<cmd>Neogit push<cr>", desc = "Push" },
    { "<leader>gs", "<cmd>Neogit stash<cr>", desc = "Stash" },
  },
  cmd = { "Neogit" },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "sindrets/diffview.nvim",

    "folke/snacks.nvim",
  },
  opts = {
    graph_style = "unicode",
    kind = "floating",
    floating = {
      relative = "editor",
      width = 0.85,
      height = 0.85,
      style = "minimal",
      border = "solid",
    },
    signs = {
      hunk = { "", "" },
      item = { "", "" },
      section = { "", "" },
    },
    commit_editor = { kind = "floating" },
    log_view = { kind = "floating" },
    commit_select_view = { kind = "floating" },
    commit_view = { kind = "floating" },
    rebase_editor = { kind = "floating" },
    reflog_view = { kind = "floating" },
    merge_editor = { kind = "floating" },
    preview_buffer = { kind = "floating_console" },
    popup = { kind = "floating" },
    stash = { kind = "floating" },
    refs_view = { kind = "floating" },
  },
  config = function(_, opts)
    require("neogit").setup(opts)
    require("highlights-nvim").add({
      links = {
        ["*"] = {
          NeogitNormal = "NormalFloat",
        },
      },
    })
  end,
}
