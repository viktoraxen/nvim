vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = true

require("autocommands")

require("lazy-bootstrap")

require("lazy-plugins")

require("options")

require("keymaps")

vim.api.nvim_create_autocmd("UIEnter", {
  desc = "Launch Neovide configuration",
  pattern = "*",
  callback = function()
    if vim.g.neovide then
      require("neovide")
    end
  end,
})
