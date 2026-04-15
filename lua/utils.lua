local M = {}

M.search_word_under_cursor = function()
  local word = "\\<" .. vim.fn.escape(vim.fn.expand("<cword>"), "\\") .. "\\>"
  if vim.fn.getreg("/") == word then
    vim.cmd("normal! n")
  else
    local pos = vim.api.nvim_win_get_cursor(0)
    vim.fn.setreg("/", word)
    vim.opt.hlsearch = true
    vim.api.nvim_win_set_cursor(0, pos)
  end
end

M.restart_neovim = function()
  local session = vim.fn.stdpath("state") .. "/restart_session.vim"
  vim.cmd("mksession! " .. vim.fn.fnameescape(session))
  vim.cmd("restart source " .. vim.fn.fnameescape(session))
end

return M
