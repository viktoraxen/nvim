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
  config = function(_, opts)
    require("codediff").setup(opts)

    -- Workaround: TabLeave clears explorer keymaps but TabEnter only restores
    -- view keymaps. Re-apply explorer keymaps when returning to a codediff tab.
    vim.api.nvim_create_autocmd("TabEnter", {
      callback = function()
        vim.schedule(function()
          local ok, lifecycle = pcall(require, "codediff.ui.lifecycle")
          if not ok then
            return
          end
          local tabpage = vim.api.nvim_get_current_tabpage()
          local explorer = lifecycle.get_explorer(tabpage)
          if explorer then
            require("codediff.ui.explorer.keymaps").setup(explorer)
            local ob, mb = lifecycle.get_buffers(tabpage)
            if ob and mb then
              local is_explorer = lifecycle.get_mode(tabpage) == "explorer"
              require("codediff.ui.view.keymaps").setup_all_keymaps(tabpage, ob, mb, is_explorer)
            end
          end
        end)
      end,
    })
  end,
}
