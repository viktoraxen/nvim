vim.g.mapleader = " "

vim.opt.swapfile = false
vim.opt.completeopt = ""
vim.o.autocomplete = false

-- Global statusline
vim.opt.laststatus = 3

vim.opt.number = false
vim.opt.showcmd = false

vim.opt.showmode = false

-- Enable break indent
vim.opt.breakindent = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.signcolumn = "auto"

-- Show tabline only when multiple tabs are open
vim.opt.showtabline = 1

vim.opt.updatetime = 250
-- Displays which-key popup later
vim.opt.timeoutlen = 1000

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.opt.fillchars = { eob = " ", msgsep = "─" }

-- Live substitutions preview
vim.opt.inccommand = "split"

-- Highlight current line number
vim.opt.cursorline = true
vim.opt.cursorlineopt = "number"

vim.opt.scrolloff = 7

vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.tabstop = 4
vim.opt.wrap = false

vim.opt.winblend = 0
vim.opt.winborder = "solid"
vim.opt.pumblend = 0
vim.opt.pumheight = 7

require("vim._core.ui2").enable({})
