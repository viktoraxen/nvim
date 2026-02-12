vim.api.nvim_create_autocmd("WinLeave", {
  desc = "Deactivate cursorline highight when leaving a window",
  pattern = "*",
  callback = function()
    vim.wo.cursorline = false
  end,
})

vim.api.nvim_create_autocmd("WinEnter", {
  desc = "Activate cursorline highight when entering a window",
  pattern = "*",
  callback = function()
    vim.wo.cursorline = true
  end,
})

vim.api.nvim_create_autocmd("CursorMoved", {
  desc = "Clear status on cursor move.",
  callback = function()
    vim.api.nvim_echo({ { "", "" } }, false, {})
  end,
})

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
        vim.cmd("normal! zz")
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

-- vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI", "WinScrolled" }, {
--     desc = "Fix scrolloff when you are at the EOF",
--     group = vim.api.nvim_create_augroup("ScrollEOF", { clear = true }),
--     callback = function()
--         if vim.api.nvim_win_get_config(0).relative ~= "" then
--             return -- Ignore floating windows
--         end
--
--         local win_height = vim.fn.winheight(0)
--         local scrolloff = math.min(vim.opt.scrolloff, math.floor(win_height / 2))
--         local visual_distance_to_eof = win_height - vim.fn.winline()
--
--         if visual_distance_to_eof < scrolloff then
--             local win_view = vim.fn.winsaveview()
--             vim.fn.winrestview({ topline = win_view.topline + scrolloff - visual_distance_to_eof })
--         end
--     end,
-- })

local hide_cursor_fts = {
  "neo-tree",
  "snacks_picker_list",
}

vim.api.nvim_create_autocmd("BufEnter", {
  desc = "Hide cursor in Neo-tree, only cursorline visible",
  callback = function()
    if vim.tbl_contains(hide_cursor_fts, vim.bo.filetype) then
      vim.o.guicursor = "a:block-Cursor/lCursor"
      vim.api.nvim_set_hl(0, "Cursor", { nocombine = true, blend = 100 })
    else
      vim.api.nvim_set_hl(0, "Cursor", {})
      vim.o.guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20"
    end
  end,
})

vim.api.nvim_create_autocmd("BufLeave", {
  desc = "Restore cursor when leaving Neo-tree",
  callback = function()
    if vim.tbl_contains(hide_cursor_fts, vim.bo.filetype) then
      vim.api.nvim_set_hl(0, "Cursor", {})
      vim.o.guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20"
    end
  end,
})

vim.api.nvim_create_autocmd({ "ColorScheme", "UIEnter" }, {
  desc = "Corrects terminal background color according to colorscheme",
  callback = function()
    if vim.api.nvim_get_hl(0, { name = "Normal" }).bg then
      io.write(string.format("\027]11;#%06x\027\\", vim.api.nvim_get_hl(0, { name = "Normal" }).bg))
    end
  end,
})

vim.api.nvim_create_autocmd("UILeave", {
  desc = "Reset terminal backgroun",
  callback = function()
    io.write("\027]111\027\\")
  end,
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)

    if client and client.server_capabilities.documentHighlightProvider then
      local highlight_augroup = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })
      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        desc = "Highlight word under cursor",
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ "WinLeave", "CursorMoved", "CursorMovedI" }, {
        desc = "Clear highlight word under cursor on move",
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })

      vim.api.nvim_create_autocmd("LspDetach", {
        desc = "Clear highlight word under cursor on LSP detach",
        group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
        callback = function(event2)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds({ group = "lsp-highlight", buffer = event2.buf })
        end,
      })
    end
  end,
})
