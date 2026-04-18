local M = {}
local hl = require("highlight-utils")

M.disabled_filetypes = {
  "Neogit",
  "codediff",
  "dap",
  "dashboard",
  "gitcommit",
  "help",
  "neo-tree",
  "nvim-pack",
  "pager",
  "qf",
  "sidekick",
  "snacks",
  "terminal",
}

local function setup_highlights()
  require("highlight-utils").set({
    WinBar = { bg = "NONE" },
    WinBarNC = { bg = "NONE" },

    WinBarDir = { fg = hl.get("Comment").fg, bg = "NONE" },
    WinBarFile = { fg = hl.get("Normal").fg, bold = true, bg = "NONE" },
  })
end

setup_highlights()

vim.api.nvim_create_autocmd("ColorScheme", {
  desc = "Refresh winbar highlights",
  callback = setup_highlights,
})

local function dir_component()
  local path = vim.fn.expand("%:.")

  if path == "" then
    return nil
  end

  local dir = vim.fn.fnamemodify(path, ":h")

  if dir == "." then
    return nil
  end

  return "%#WinBarDir#" .. "󰷏 " .. dir:gsub("%%", "%%%%")
end

local function file_component()
  local filename = vim.fn.expand("%:t")

  if filename == "" then
    return nil
  end

  return "%#WinBarFile#" .. "󰧮 " .. filename:gsub("%%", "%%%%")
end

local function is_disabled()
  if vim.w.codediff_restore == 1 then
    return true
  end

  if vim.bo.buftype == "terminal" then
    return true
  end

  local ft = vim.bo.filetype

  for _, pattern in ipairs(M.disabled_filetypes) do
    if ft == pattern or ft:find(pattern, 1, true) == 1 then
      return true
    end
  end

  return false
end

function M.render()
  if is_disabled() then
    return ""
  end

  local modified = vim.bo.modified and "%#WinBarFile# ~" or ""
  local readonly = vim.bo.readonly and "%#WinBarFile# *" or ""

  local search = ""

  if vim.v.hlsearch == 1 then
    local ok, count = pcall(vim.fn.searchcount, { maxcount = 999 })

    if ok and count.total and count.total > 0 then
      search = "%#WinBarDir# " .. count.current .. "/" .. count.total
    end
  end

  local components = {
    "  ",
    file_component() or "",
    modified,
    readonly,
    "  ",
    dir_component() or "",
    "%=",
    search,
    "  ",
  }

  return table.concat(components)
end

local function apply()
  if not vim.api.nvim_win_is_valid(0) or vim.api.nvim_win_get_config(0).relative ~= "" or is_disabled() then
    return
  end

  vim.wo.winbar = "%{%v:lua.require('winbar').render()%}"
end

vim.api.nvim_create_autocmd({ "BufWinEnter", "FileType", "BufEnter" }, {
  desc = "Set or disable winbar per window",
  callback = function()
    vim.schedule(apply)
  end,
})

vim.api.nvim_create_autocmd({ "VimEnter", "SessionLoadPost" }, {
  desc = "Set winbar for every window after startup/session restore",
  callback = function()
    vim.schedule(function()
      for _, win in ipairs(vim.api.nvim_list_wins()) do
        vim.api.nvim_win_call(win, apply)
      end
    end)
  end,
})

return M
