vim.cmd("colorscheme catppuccin")

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

vim.opt.winblend = 15
vim.opt.pumblend = 15
vim.opt.pumheight = 10

-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1

vim.ui.open = function(url)
    vim.fn.jobstart({ "explorer.exe", url }, { detach = true })
end

local diagnostic_icons = {
    error = "",
    warn = "",
    info = "",
    hint = "",
}
vim.fn.sign_define('DiagnosticSignError', { text = diagnostic_icons.error, texthl = 'DiagnosticSignError' })
vim.fn.sign_define('DiagnosticSignWarn', { text = diagnostic_icons.warn, texthl = 'DiagnosticSignWarn' })
vim.fn.sign_define('DiagnosticSignInfo', { text = diagnostic_icons.info, texthl = 'DiagnosticSignInfo' })
vim.fn.sign_define('DiagnosticSignHint', { text = diagnostic_icons.hint, texthl = 'DiagnosticSignHint' })

vim.diagnostic.config {
    underline = true,
    signs = false,
    update_in_insert = false,
    -- virtual_lines = { current_line = true },
    -- virtual_text = { current_line = true },
    severity_sort = true,
    float = {
        border = 'rounded',
        source = 'if_many',
        header = '',
        scope = 'line',
        prefix = function(diagnostic, i, total)
            local icons_hls = {
                [vim.diagnostic.severity.ERROR] = { diagnostic_icons.error, "DiagnosticError" },
                [vim.diagnostic.severity.WARN]  = { diagnostic_icons.warn, "DiagnosticWarn" },
                [vim.diagnostic.severity.INFO]  = { diagnostic_icons.info, "DiagnosticInfo" },
                [vim.diagnostic.severity.HINT]  = { diagnostic_icons.hint, "DiagnosticHint" },
            }
            local icon, hl = unpack(icons_hls[diagnostic.severity] or { " ", "" })
            return icon .. " ", hl
        end,
        suffix = ''
    }
}

local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview

---@diagnostic disable-next-line: duplicate-set-field
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
    opts = opts or {}
    opts.border = "rounded" -- Or any other border
    return orig_util_open_floating_preview(contents, syntax, opts, ...)
end
