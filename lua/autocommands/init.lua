vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  desc = "Remove trailing whitespace on save",
  pattern = { "*" },
  callback = function()
    local save_cursor = vim.fn.getpos(".")
    vim.cmd([[%s/\s\+$//e]])
    vim.fn.setpos(".", save_cursor)
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "html",
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
    "css",
    "json",
    "lua",
  },
  callback = function()
    vim.bo.shiftwidth = 2
    vim.bo.tabstop = 2
  end,
  desc = "2 space indentation for certain filetypes",
})

vim.api.nvim_create_autocmd("BufReadPost", {
  desc = "Return to last cursor position when opening new file",
  callback = function(args)
    local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
    local line_count = vim.api.nvim_buf_line_count(args.buf)

    if mark[1] > 0 and mark[1] <= line_count then
      vim.api.nvim_win_set_cursor(0, mark)

      vim.schedule(function()
        if vim.api.nvim_get_mode().mode ~= "t" then
          vim.cmd("normal! zz")
        end
      end)
    end
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  desc = "Open help in vertical split",
  pattern = "help",
  command = "wincmd L",
})

vim.api.nvim_create_autocmd("VimResized", {
  desc = "Resize splits when windows resizes",
  command = "wincmd =",
})

vim.api.nvim_create_autocmd("BufRead", {
  desc = "Syntax highlighting for dotenv-files",
  pattern = { ".env", ".env.*" },
  callback = function()
    vim.bo.filetype = "dosini"
  end,
})

local cmdline_timer

vim.api.nvim_create_autocmd("CursorHold", {
  desc = "Clear commandline after a delay.",
  callback = function()
    if cmdline_timer then
      vim.fn.timer_stop(cmdline_timer)
    end

    cmdline_timer = vim.fn.timer_start(3000, function()
      vim.schedule(function()
        if vim.api.nvim_get_mode().mode == "n" then
          vim.cmd("echo ''")
        end
      end)
    end)
  end,
})

vim.api.nvim_create_autocmd("UILeave", {
  desc = "Reset terminal backgroun",
  callback = function()
    io.write("\027]111\027\\")
  end,
})

require("autocommands.plugins")
