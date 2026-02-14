require("lazy").setup({
  { import = "plugins" },
  { import = "plugins.colorschemes" },
}, {
  install = {
    colorscheme = { "kanagawa" },
  },
  ui = {
    border = "solid",
    backdrop = 100,
    size = { width = 0.85, height = 0.8 },
  },
  dev = {
    path = "~/dev",
  },
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "lazy",
  callback = function()
    local win = vim.api.nvim_get_current_win()
    vim.schedule(function()
      if vim.api.nvim_win_is_valid(win) then
        vim.wo[win].winhighlight = "Normal:LazyNormal,FloatBorder:LazyNormal"
      end
    end)
  end,
})

local map = require("utils.keymap")

map.n("<leader>L", "<cmd>Lazy<cr>", "Lazy")
