local layouts = require("config.snacks.layouts")

local M = {}

M.all = {
  hidden = true,
  ignored = true,
  follow = true,
}

M.vscode = { layout = layouts.vscode }
M.vscode_all = vim.tbl_deep_extend("force", M.vscode, M.all)

return M
