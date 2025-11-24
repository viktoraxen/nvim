local layouts = require 'plugins.snacks.layouts'

local M = {}

M.all = {
  hidden = true,
  ignored = true,
  follow = true,
}

M.git_status = {
  layout = layouts.adaptive_width(layouts.git_wide, layouts.narrow),
  win = {
    input = {
      keys = {
        ['<c-l>'] = { 'git_stage', mode = { 'n', 'i' } },
        ['<C-i'] = { 'git_restore', mode = { 'n', 'i' } },
      },
    },
  },
}

M.vscode = { layout = layouts.vscode }
M.vscode_all = vim.tbl_deep_extend('force', M.vscode, M.all)

return M
