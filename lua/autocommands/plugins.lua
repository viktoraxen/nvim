local cursor_hidden = false
local hide_cursor_fts = { ["neo-tree"] = true, ["snacks_picker_list"] = true, ["NeogitPopup"] = true }

local function hide_cursor()
  cursor_hidden = true
  vim.o.guicursor = "a:HiddenCursor/HiddenCursor"
end

local function show_cursor()
  cursor_hidden = false
  vim.o.guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20"
end

vim.api.nvim_create_autocmd({ "WinEnter", "FileType" }, {
  desc = "Combined WinEnter: cursor visibility, indent guides",
  callback = function()
    if hide_cursor_fts[vim.bo.filetype] then
      hide_cursor()
    elseif cursor_hidden then
      show_cursor()
    end

    local whl = vim.wo.winhighlight
    whl = whl:gsub(",?SnacksIndent[^,]*Hidden", ""):gsub("^,", "")
    vim.wo.winhighlight = whl
  end,
})

vim.api.nvim_create_autocmd("WinLeave", {
  desc = "Combined WinLeave: cursor restore, indent guides",
  callback = function()
    if hide_cursor_fts[vim.bo.filetype] then
      show_cursor()
    end

    local whl = vim.wo.winhighlight
    local hide = "SnacksIndent:SnacksIndentHidden,SnacksIndentScope:SnacksIndentHidden"
    if not whl:find("SnacksIndentHidden") then
      vim.wo.winhighlight = whl == "" and hide or (whl .. "," .. hide)
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
  desc = "Colorscheme-dependent highlights and terminal sync",
  callback = function()
    local bg = vim.api.nvim_get_hl(0, { name = "Normal" }).bg
    if bg then
      io.write(string.format("\027]11;#%06x\027\\", bg))
      vim.api.nvim_set_hl(0, "SnacksIndentHidden", { fg = bg, nocombine = true })
    end
    vim.api.nvim_set_hl(0, "HiddenCursor", { nocombine = true, blend = 100 })
  end,
})

vim.api.nvim_create_autocmd({ "BufWinEnter", "FileType" }, {
  desc = "Refresh lualine winbar after codediff clears it",
  callback = function()
    if vim.w.codediff_restore ~= 1 then
      return
    end
    vim.schedule(function()
      pcall(function()
        require("lualine").refresh({ place = { "winbar" } })
      end)
    end)
  end,
})
