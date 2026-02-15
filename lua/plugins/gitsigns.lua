return {
  "lewis6991/gitsigns.nvim",
  event = "BufEnter",
  keys = {
    { "<leader>ghh", "<cmd>Gitsigns preview_hunk_inline<cr>", desc = "Preview" },
    { "<leader>ghs", "<cmd>Gitsigns stage_hunk<cr>", desc = "Stage" },
    { "<leader>ghr", "<cmd>Gitsigns reset_hunk<cr>", desc = "Reset" },
    { "<leader>gj", "<cmd>Gitsigns nav_hunk next<cr>", desc = "Next hunk" },
    { "<leader>gk", "<cmd>Gitsigns nav_hunk prev<cr>", desc = "Previous hunk" },
    { "<leader>gB", "<cmd>Gitsigns toggle_current_line_blame<cr>", desc = "Toggle blame" },
  },
  config = function(_, opts)
    require("gitsigns").setup(opts)

    -- Override gitsigns' number_hl_group on the cursor line with CursorLineNr
    local ns = vim.api.nvim_create_namespace("gitsigns_cursorline_nr")
    vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
      callback = function()
        local buf = vim.api.nvim_get_current_buf()
        vim.api.nvim_buf_clear_namespace(buf, ns, 0, -1)
        if vim.wo.number or vim.wo.relativenumber then
          local row = vim.api.nvim_win_get_cursor(0)[1] - 1
          vim.api.nvim_buf_set_extmark(buf, ns, row, 0, {
            number_hl_group = "CursorLineNr",
            priority = 200,
          })
        end
      end,
    })

    require("highlights-nvim").add({
      customizations = {
        ["*"] = {
          GitSignsAdd = { bg = false },
          GitSignsChange = { bg = false },
          GitSignsDelete = { bg = false },
        },
      },
      links = {
        ["*"] = {
          GitSignsStagedChange = "GitSignsChange",
          GitSignsStagedAdd = "GitSignsAdd",
          GitSignsStagedDelete = "GitSignsDelete",
        },
      },
    })
  end,
  opts = {
    signs = {
      add = { text = "│" },
      change = { text = "│" },
      delete = { text = "_" },
      topdelete = { text = "‾" },
      changedelete = { text = "~" },
      untracked = { text = "┆" },
    },
    signs_staged = {
      add = { text = "┃" },
      change = { text = "┃" },
      delete = { text = "_" },
      topdelete = { text = "‾" },
      changedelete = { text = "~" },
      untracked = { text = "┆" },
    },
    signs_staged_enable = true,
    signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
    numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
    linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
    word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
    watch_gitdir = {
      follow_files = true,
    },
    auto_attach = true,
    attach_to_untracked = false,
    current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
      delay = 1000,
      ignore_whitespace = false,
      virt_text_priority = 100,
      use_focus = true,
    },
    current_line_blame_formatter = "<author>, <author_time:%R> - <summary>",
    sign_priority = 6,
    update_debounce = 100,
    status_formatter = nil, -- Use default
    max_file_length = 40000, -- Disable if file is longer than this (in lines)
    preview_config = {
      -- Options passed to nvim_open_win
      style = "minimal",
      relative = "cursor",
      row = 0,
      col = 1,
    },
  },
}
