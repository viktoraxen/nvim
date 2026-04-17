local M = {}

local hl = require("highlight-utils")

local mode_map = {
  ["n"] = { "Normal", "StlModeNormal" },
  ["no"] = { "Normal", "StlModeNormal" },
  ["nov"] = { "Normal", "StlModeNormal" },
  ["noV"] = { "Normal", "StlModeNormal" },
  ["no\22"] = { "Normal", "StlModeNormal" },
  ["niI"] = { "Normal", "StlModeNormal" },
  ["niR"] = { "Normal", "StlModeNormal" },
  ["niV"] = { "Normal", "StlModeNormal" },
  ["nt"] = { "Normal", "StlModeNormal" },
  ["ntT"] = { "Normal", "StlModeNormal" },
  ["i"] = { "Insert", "StlModeInsert" },
  ["ic"] = { "Insert", "StlModeInsert" },
  ["ix"] = { "Insert", "StlModeInsert" },
  ["v"] = { "Visual", "StlModeVisual" },
  ["vs"] = { "Visual", "StlModeVisual" },
  ["V"] = { "V-Line", "StlModeVisual" },
  ["Vs"] = { "V-Line", "StlModeVisual" },
  ["\22"] = { "V-BLOCK", "StlModeVisual" },
  ["\22s"] = { "V-BLOCK", "StlModeVisual" },
  ["s"] = { "Select", "StlModeVisual" },
  ["S"] = { "S-Line", "StlModeVisual" },
  ["\19"] = { "S-BLOCK", "StlModeVisual" },
  ["R"] = { "Replace", "StlModeReplace" },
  ["Rc"] = { "Replace", "StlModeReplace" },
  ["Rx"] = { "Replace", "StlModeReplace" },
  ["Rv"] = { "V-Replace", "StlModeReplace" },
  ["Rvc"] = { "V-Replace", "StlModeReplace" },
  ["Rvx"] = { "V-Replace", "StlModeReplace" },
  ["c"] = { "Command", "StlModeCommand" },
  ["cv"] = { "Command", "StlModeCommand" },
  ["ce"] = { "Command", "StlModeCommand" },
  ["r"] = { "Prompt", "StlModeCommand" },
  ["rm"] = { "Prompt", "StlModeCommand" },
  ["r?"] = { "Confirm", "StlModeCommand" },
  ["!"] = { "Shell", "StlModeTerminal" },
  ["t"] = { "Terminal", "StlModeTerminal" },
}

local diag_icons = {
  [vim.diagnostic.severity.ERROR] = "󰅚 ",
  [vim.diagnostic.severity.WARN] = "󰀪 ",
  [vim.diagnostic.severity.INFO] = "󰋽 ",
  [vim.diagnostic.severity.HINT] = "󰌶 ",
}

local diag_hl = {
  [vim.diagnostic.severity.ERROR] = "StlDiagError",
  [vim.diagnostic.severity.WARN] = "StlDiagWarn",
  [vim.diagnostic.severity.INFO] = "StlDiagInfo",
  [vim.diagnostic.severity.HINT] = "StlDiagHint",
}

local _git_branch = nil
local _git_cwd = nil

local function update_git_branch(force)
  local cwd = vim.fn.getcwd()

  if not force and cwd == _git_cwd then
    return
  end

  _git_cwd = cwd

  vim.system({ "git", "rev-parse", "--abbrev-ref", "HEAD" }, { cwd = cwd, text = true }, function(result)
    vim.schedule(function()
      if result.code == 0 and result.stdout then
        local branch = vim.trim(result.stdout)
        _git_branch = branch ~= "" and branch or nil
      else
        _git_branch = nil
      end
      vim.cmd.redrawstatus()
    end)
  end)
end

vim.api.nvim_create_autocmd({ "BufEnter", "DirChanged" }, {
  desc = "Update git branch for statusline",
  callback = function()
    update_git_branch(false)
  end,
})

vim.api.nvim_create_autocmd("FocusGained", {
  desc = "Force-refresh git branch (may have changed externally)",
  callback = function()
    update_git_branch(true)
  end,
})

vim.api.nvim_create_autocmd("ModeChanged", {
  desc = "Redraw statusline on mode change",
  callback = function()
    vim.cmd.redrawstatus()
  end,
})

local function setup_highlights()
  hl.set({
    StatusLine = { bg = "NONE", update = true },
    StatusLineNC = { bg = "NONE", update = true },

    StlModeNormal = { fg = hl.get("Function").fg, bold = true },
    StlModeInsert = { fg = hl.get("String").fg, bold = true },
    StlModeVisual = { fg = hl.get("Keyword").fg, bold = true },
    StlModeReplace = { fg = hl.get("DiagnosticError").fg, bold = true },
    StlModeCommand = { fg = hl.get("DiagnosticWarn").fg, bold = true },
    StlModeTerminal = { fg = hl.get("DiagnosticInfo").fg, bold = true },

    StlDiagError = { fg = hl.get("DiagnosticError").fg },
    StlDiagWarn = { fg = hl.get("DiagnosticWarn").fg },
    StlDiagInfo = { fg = hl.get("DiagnosticInfo").fg },
    StlDiagHint = { fg = hl.get("DiagnosticHint").fg },

    StlGitBranch = { fg = hl.get("Comment").fg },
    StlVenv = { fg = hl.get("Comment").fg },
    StlFiletype = { fg = hl.get("Normal").fg },
    StlPosition = { fg = hl.get("Comment").fg },
  })
end

setup_highlights()

vim.api.nvim_create_autocmd("ColorScheme", {
  desc = "Refresh statusline highlights",
  callback = setup_highlights,
})

local function pad(width, content)
  return "%-" .. width .. "." .. width .. "(" .. content .. "%)"
end

local function mode_component()
  local mode = vim.api.nvim_get_mode().mode
  local entry = mode_map[mode] or mode_map[mode:sub(1, 1)] or { "UNKNOWN", "StlModeNormal" }
  return pad(10, "%#" .. entry[2] .. "# " .. entry[1] .. " ")
end

local function diagnostics_component()
  local counts = vim.diagnostic.count(0)
  local parts = {}

  for _, severity in ipairs({
    vim.diagnostic.severity.ERROR,
    vim.diagnostic.severity.WARN,
    vim.diagnostic.severity.INFO,
    vim.diagnostic.severity.HINT,
  }) do
    local count = counts[severity] or 0
    if count > 0 then
      table.insert(parts, "%#" .. diag_hl[severity] .. "#" .. diag_icons[severity] .. " " .. count)
    end
  end

  if #parts == 0 then
    return nil
  end

  return pad(20, table.concat(parts, " "))
end

local function git_component()
  if not _git_branch then
    return nil
  end

  local branch = _git_branch:gsub("%%", "%%%%")
  return pad(10, "%#StlGitBranch#  " .. branch)
end

local function venv_component()
  local venv = os.getenv("VIRTUAL_ENV")
  if not venv then
    return nil
  end

  local name = vim.fn.fnamemodify(venv, ":t")
  return pad(7, "%#StlVenv# 󰹩 " .. name)
end

local function filetype_component()
  local ft = vim.bo.filetype
  if ft == "" then
    return nil
  end

  local ok, icon, hl_group = pcall(MiniIcons.get, "filetype", ft)

  if ok and icon then
    return "%#" .. hl_group .. "#" .. icon .. " %#StlFiletype#" .. ft
  end

  return "%#StlFiletype#" .. ft
end

local function position_component()
  local mode = vim.api.nvim_get_mode().mode
  local entry = mode_map[mode] or mode_map[mode:sub(1, 1)] or { "UNKNOWN", "StlModeNormal" }
  local hl_str = "%#" .. entry[2] .. "#"
  return pad(7, hl_str .. "%l:%c") .. pad(4, hl_str .. "%p%%")
end

local function padding(width)
  return pad(width, "")
end

function M.render()
  local components = {
    padding(1),
    mode_component(),
    padding(2),
    diagnostics_component() or "",
    "%=",
    venv_component() or "",
    padding(2),
    git_component() or "",
    padding(2),
    filetype_component() or "",
    padding(5),
    position_component(),
    padding(1),
  }

  return table.concat(components, "%#StatusLine#")
end

vim.o.statusline = "%!v:lua.require('statusline').render()"

return M
