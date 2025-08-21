vim.cmd("colorscheme catppuccin")

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
vim.opt.fillchars = { eob = " " }

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

vim.opt.winblend = 0
vim.opt.winborder = "solid"
vim.opt.pumblend = 0
vim.opt.pumheight = 10

vim.ui.open = function(url)
    vim.fn.jobstart({ "explorer.exe", url }, { detach = true })
end

local diagnostic_icons = {
    error = "",
    warn = "",
    info = "",
    hint = "",
}

local get_diagnostic_icon = function(diagnostic, i, total)
    local icons_hls = {
        [vim.diagnostic.severity.ERROR] = { diagnostic_icons.error, "DiagnosticError" },
        [vim.diagnostic.severity.WARN]  = { diagnostic_icons.warn, "DiagnosticWarn" },
        [vim.diagnostic.severity.INFO]  = { diagnostic_icons.info, "DiagnosticInfo" },
        [vim.diagnostic.severity.HINT]  = { diagnostic_icons.hint, "DiagnosticHint" },
    }
    local icon, hl = unpack(icons_hls[diagnostic.severity] or { " ", "" })
    return icon .. " ", hl
end

vim.fn.sign_define('DiagnosticSignError', { text = diagnostic_icons.error, texthl = 'DiagnosticSignError' })
vim.fn.sign_define('DiagnosticSignWarn', { text = diagnostic_icons.warn, texthl = 'DiagnosticSignWarn' })
vim.fn.sign_define('DiagnosticSignInfo', { text = diagnostic_icons.info, texthl = 'DiagnosticSignInfo' })
vim.fn.sign_define('DiagnosticSignHint', { text = diagnostic_icons.hint, texthl = 'DiagnosticSignHint' })

vim.diagnostic.config {
    underline = true,
    signs = false,
    update_in_insert = false,
    virtual_text = {
        prefix = get_diagnostic_icon,
    },
    severity_sort = true,
    float = {
        source = 'if_many',
        header = '',
        scope = 'line',
        prefix = get_diagnostic_icon,
        suffix = ''
    }
}
