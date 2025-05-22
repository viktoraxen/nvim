-- Make line numbers default
vim.opt.number = false

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
vim.opt.clipboard = 'unnamedplus'

-- Enable break indent
vim.opt.breakindent = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
-- vim.opt.signcolumn = 'yes'

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
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.wrap = false

vim.opt.winblend = 15
vim.opt.pumblend = 15
vim.opt.pumheight = 10

vim.diagnostic.config {
    underline = true,
    signs = false,
    update_in_insert = false,
    virtual_lines = { current_line = true },
    -- virtual_text = { current_line = true },
    severity_sort = true,
    float = {
        border = 'rounded',
        source = 'if_many',
        header = '',
        scope = 'line',
        prefix = require('utils.diagnostics').diagnostic_prefix,
        suffix = ''
    }
}

vim.api.nvim_set_hl(0, "NormalFloat", { link = "Normal" })
vim.api.nvim_set_hl(0, "FloatBorder", { link = "DiagnosticInfo" })
vim.api.nvim_set_hl(0, "ToggleTerm1FloatBorder", { link = "FloatBorder" })

vim.api.nvim_set_hl(0, "NeoTreeNormal", { link = "Normal" })
vim.api.nvim_set_hl(0, "NeoTreeNormalNC", { link = "Normal" })
vim.api.nvim_set_hl(0, "NeoTreeFloatBorder", { link = "Comment" })

vim.api.nvim_set_hl(0, "SnacksPickerInputCursorLine", { link = "Normal" })
