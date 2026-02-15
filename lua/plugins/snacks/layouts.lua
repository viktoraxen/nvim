local border = require("config").border

local M = {}

M.vscode = {
  preview = false,
  layout = {
    box = "vertical",
    row = 0.25,
    width = 0.5,
    min_width = 75,
    height = 0.5,
    backdrop = false,
    {
      win = "preview",
      title = "{preview}",
      height = 0.5,
      border = border,
    },
    {
      box = "vertical",
      {
        win = "input",
        height = 1,
        border = border,
        title = "{title} {live} {flags}",
      },
      {
        win = "list",
        border = border,
      },
    },
  },
}

local preview = {
  preview = true,
  layout = {
    height = 0.85,
    row = 0.05,
  },
}

M.vscode_preview = vim.tbl_deep_extend("force", { layout = M.vscode }, preview)
-- M.vscode_preview_all = vim.tbl_deep_extend("force", M.vscode_preview, M.vscode_all)

M.wide = {
  layout = {
    box = "horizontal",
    min_width = 120,
    width = 0.85,
    height = 0.85,
    backdrop = false,
    {
      box = "vertical",
      {
        win = "input",
        height = 1,
        border = border,
        title = "{title} {live} {flags}",
      },
      { win = "list", border = border },
    },
    {
      win = "preview",
      title = "{preview}",
      border = border,
      width = 0.55,
    },
  },
}

M.narrow = {
  layout = {
    box = "vertical",
    width = 0.9,
    height = 0.9,
    backdrop = false,
    {
      win = "preview",
      title = "{preview}",
      height = 0.65,
      border = border,
    },
    {
      box = "vertical",
      {
        win = "input",
        height = 1,
        border = border,
        title = "{title} {live} {flags}",
      },
      {
        win = "list",
        border = border,
      },
    },
  },
}

M.git_wide = {
  layout = {
    box = "horizontal",
    min_width = 120,
    width = 0.85,
    height = 0.85,
    backdrop = false,
    {
      box = "vertical",
      {
        win = "input",
        height = 1,
        border = border,
        title = "{title} {live} {flags}",
      },
      { win = "list", border = border },
    },
    {
      win = "preview",
      title = "{preview}",
      border = border,
      width = 0.65,
    },
  },
}

function M.adaptive_width(wide, narrow)
  return function()
    return vim.o.columns >= 120 and wide or narrow
  end
end

return M
