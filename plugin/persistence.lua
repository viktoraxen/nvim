vim.pack.add({ "https://github.com/folke/persistence.nvim" })

require("persistence").setup()

vim.api.nvim_create_autocmd("User", {
  pattern = "PersistenceSavePre",
  callback = function()
    for _, win in ipairs(vim.api.nvim_list_wins()) do
      local buf = vim.api.nvim_win_get_buf(win)
      local bt = vim.bo[buf].buftype

      if bt == "terminal" or bt == "help" or bt == "nofile" then
        pcall(vim.api.nvim_win_close, win, true)
      end
    end
  end,
})
