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
    commit_editor = { staged_diff_split_kind = "vsplit" },
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

  local hl = require("highlight-utils")

  hl.set({
    NeogitDiffHeader = { fg = hl.fg("Exception"), bold = true },
    NeogitFloatHeader = { bold = true },
    NeogitFloatHeaderHighlight = { fg = hl.fg("Operator"), bold = true },
  })

  hl.link({
    NeogitNormalFloat = "LightFloat",
  })

  vim.api.nvim_create_autocmd("FileType", {
    desc = "Style Neogit popup floats",
    pattern = "NeogitPopup",
    callback = function()
      local win = vim.api.nvim_get_current_win()
      if vim.api.nvim_win_get_config(win).relative == "" then
        return
      end

      vim.schedule(function()
        if not vim.api.nvim_win_is_valid(win) then
          return
        end

        local ns = vim.api.nvim_get_hl_ns({ winid = win })

        if ns > 0 then
          vim.api.nvim_set_hl(ns, "NormalFloat", { link = "Normal" })
          vim.api.nvim_set_hl(ns, "FloatBorder", { link = "WinSeparator" })
        end
      end)
    end,
  })
end)
