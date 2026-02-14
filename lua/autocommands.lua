-- vim.api.nvim_create_autocmd("WinLeave", {
--   desc = "Deactivate cursorline highight when leaving a window",
--   pattern = "*",
--   callback = function()
--     vim.wo.cursorline = false
--   end,
-- })

-- vim.api.nvim_create_autocmd("WinEnter", {
--   desc = "Activate cursorline highight when entering a window",
--   pattern = "*",
--   callback = function()
--     vim.wo.cursorline = true
--   end,
-- })

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

local cursor_hidden = false
local hide_cursor_fts = { ["neo-tree"] = true, ["snacks_picker_list"] = true, ["NeogitPopup"] = true }

vim.api.nvim_set_hl(0, "HiddenCursor", { nocombine = true, blend = 100 })

local function hide_cursor()
  cursor_hidden = true
  vim.o.guicursor = "a:HiddenCursor/HiddenCursor"
end

local function show_cursor()
  cursor_hidden = false
  vim.o.guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20"
end

vim.api.nvim_create_autocmd({ "WinEnter", "FileType" }, {
  desc = "Hide cursor in tree/picker list, show elsewhere",
  callback = function()
    if hide_cursor_fts[vim.bo.filetype] then
      hide_cursor()
    elseif cursor_hidden then
      show_cursor()
    end
  end,
})

vim.api.nvim_create_autocmd("WinLeave", {
  desc = "Restore cursor when leaving tree/picker list",
  callback = function()
    if hide_cursor_fts[vim.bo.filetype] then
      show_cursor()
    end
  end,
})

vim.api.nvim_create_autocmd("InsertEnter", {
  desc = "Restore cursor when entering insert mode (handles noautocmd windows)",
  callback = function()
    if cursor_hidden and not hide_cursor_fts[vim.bo.filetype] then
      show_cursor()
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

vim.api.nvim_create_autocmd({ "ColorScheme", "UIEnter" }, {
  desc = "Re-create HiddenCursor highlight after colorscheme change",
  callback = function()
    vim.api.nvim_set_hl(0, "HiddenCursor", { nocombine = true, blend = 100 })
  end,
})

vim.api.nvim_create_autocmd({ "ColorScheme", "UIEnter" }, {
  desc = "Setup hidden indent guide highlight matching Normal background",
  callback = function()
    local bg = vim.api.nvim_get_hl(0, { name = "Normal" }).bg
    if bg then
      vim.api.nvim_set_hl(0, "SnacksIndentHidden", { fg = bg, nocombine = true })
    end
  end,
})

vim.api.nvim_create_autocmd("WinLeave", {
  desc = "Hide snacks indent guides in inactive windows",
  callback = function()
    local whl = vim.wo.winhighlight
    local hide = "SnacksIndent:SnacksIndentHidden,SnacksIndentScope:SnacksIndentHidden"
    if not whl:find("SnacksIndentHidden") then
      vim.wo.winhighlight = whl == "" and hide or (whl .. "," .. hide)
    end
  end,
})

vim.api.nvim_create_autocmd("WinEnter", {
  desc = "Show snacks indent guides in active window",
  callback = function()
    local whl = vim.wo.winhighlight
    whl = whl:gsub(",?SnacksIndent:SnacksIndentHidden", "")
    whl = whl:gsub(",?SnacksIndentScope:SnacksIndentHidden", "")
    whl = whl:gsub("^,", "")
    vim.wo.winhighlight = whl
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
