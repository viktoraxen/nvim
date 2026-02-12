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
    integrations = {
      snacks = false,
    },
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

    local function center_float(win, buf, opts)
      local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
      local width = 0
      for _, line in ipairs(lines) do
        width = math.max(width, vim.fn.strdisplaywidth(line))
      end
      width = width + 2

      local max_height = opts and opts.max_height
      local height = math.min(#lines, max_height or #lines)
      local row = math.floor((vim.o.lines - height) / 2)
      local col = math.floor((vim.o.columns - width) / 2)

      vim.api.nvim_win_set_config(win, {
        relative = "editor",
        anchor = "NW",
        width = width,
        height = height,
        row = row,
        col = col,
        border = "solid",
      })

      vim.wo[win].winhighlight = "NormalFloat:WhichKeyNormal,FloatBorder:WhichKeyNormal"
    end

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "NeogitPopup",
      callback = function()
        vim.schedule(function()
          vim.schedule(function()
            local win = vim.api.nvim_get_current_win()
            center_float(win, vim.api.nvim_win_get_buf(win))
          end)
        end)
      end,
    })

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "gitcommit",
      callback = function()
        local win = vim.api.nvim_get_current_win()
        if vim.api.nvim_win_get_config(win).relative == "" then
          return
        end
        vim.schedule(function()
          center_float(win, vim.api.nvim_win_get_buf(win), { max_height = math.floor(vim.o.lines * 0.5) })
        end)
      end,
    })
  end,
}
