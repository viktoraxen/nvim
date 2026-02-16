local config = require("config")

vim.cmd("colorscheme kanagawa")

-- Don't use swapfile
vim.opt.swapfile = false

-- Global statusline
vim.opt.laststatus = 3

-- Make line numbers default
vim.opt.number = false

-- Don't show the previous keystroke in bottom right corner
vim.opt.showcmd = false

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
vim.opt.clipboard = "unnamedplus"

if vim.env.SSH_TTY then
  vim.g.clipboard = {
    name = "OSC 52",
    copy = {
      ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
      ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
    },
    paste = {
      ["+"] = require("vim.ui.clipboard.osc52").paste("+"),
      ["*"] = require("vim.ui.clipboard.osc52").paste("*"),
    },
  }
end

-- Enable break indent
vim.opt.breakindent = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.signcolumn = "no"

-- Show tabline even with only one tab open
-- vim.opt.showtabline = 2

-- Decrease update time
vim.opt.updatetime = 250

-- Displays which-key popup later
vim.opt.timeoutlen = 1000

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.opt.fillchars = { eob = " " }

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- Show which line your cursor is on
vim.opt.cursorline = true
vim.opt.cursorlineopt = "number"

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 7

vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.tabstop = 4
vim.opt.wrap = false

vim.opt.winblend = 5
-- vim.opt.winborder = config.border
vim.opt.winborder = "none"
vim.opt.pumblend = 5
vim.opt.pumheight = 10

vim.ui.open = function(url)
  vim.fn.jobstart({ "explorer.exe", url }, { detach = true })
end

local di = config.icons.diagnostics

local function get_diagnostic_icon(diagnostic, _, _)
  local icons_hls = {
    [vim.diagnostic.severity.ERROR] = { di.error .. " ", "DiagnosticError" },
    [vim.diagnostic.severity.WARN] = { di.warn .. " ", "DiagnosticWarn" },
    [vim.diagnostic.severity.INFO] = { di.info .. " ", "DiagnosticInfo" },
    [vim.diagnostic.severity.HINT] = { di.hint .. " ", "DiagnosticHint" },
  }
  local icon, hl = unpack(icons_hls[diagnostic.severity] or { " ", "" })
  return icon .. " ", hl
end

vim.fn.sign_define("DiagnosticSignError", { text = di.error .. " ", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = di.warn .. " ", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInfo", { text = di.info .. " ", texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text = di.hint .. " ", texthl = "DiagnosticSignHint" })

vim.diagnostic.config({
  underline = true,
  signs = false,
  update_in_insert = true,
  virtual_text = false,
  severity_sort = true,
  float = {
    source = "if_many",
    header = "",
    scope = "line",
    prefix = get_diagnostic_icon,
    suffix = "",
  },
})
