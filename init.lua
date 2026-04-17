vim.g._startuptime = vim.uv.hrtime()

vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = true

require("highlights")

require("colorscheme")

require("winbar")

require("statusline")

require("options")

require("diagnostics")

require("autocommands")

require("usercommands")
