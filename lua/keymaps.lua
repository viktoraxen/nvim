local map = require('utils.keymap')

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
local clear_hl_and_notifications = function()
    vim.cmd('nohlsearch')
    Snacks.notifier.hide()
end

map.n('<Esc>', clear_hl_and_notifications, 'Clear search highlight and notifications')

-- Groups
map.l_group('g', 'Git')
map.l_group('d', 'Debug')
map.l_group('l', 'Language Server')
map.l_group('p', 'Peek')
map.l_group('s', 'Search')

-- Visual editing
map.v('=', '=gv', 'Auto-indent selection')
map.v('>', '>gv', 'Indent selection')
map.v('<', '<gv', 'De-indent selection')

map.ln('R', ':%s/<c-r><c-w>//g<left><left>', 'Replace word under cursor')

-- Basic
map.ln('q', '<cmd>q<cr>', 'Close buffer')
map.ln('Q', '<cmd>qa<cr>', 'Close all')
map.ln('w', '<cmd>w<cr>', 'Save buffer')


map.n('gh', vim.diagnostic.open_float, 'Show line diagnostics')
map.n('gj', vim.diagnostic.goto_next, 'Next diagnostic')
map.n('gk', vim.diagnostic.goto_prev, 'Previous diagnostic')

-- LSP keymaps
map.n('K', vim.lsp.buf.hover, 'Hover')

map.group('g', 'Go to')
map.group('gr', 'LSP Buffer')

map.n('gra', vim.lsp.buf.code_action, 'Code action')
map.n('grf', vim.lsp.buf.format, 'Format buffer')
map.n('grn', vim.lsp.buf.rename, 'Rename symbol')

-- Copy
map.n('yA', 'ggVGy', 'Copy all')
map.n('vA', 'ggVG', 'Select all')
map.n('dA', 'ggVGd', 'Delete all')
map.n('cA', 'ggVGc', 'Change all')

-- Insert mode
map.i('jj', '<Esc>', 'Exit insert mode')
map.i('<C-h>', '<C-w>', 'Remove word before')
map.i('<C-l>', '<C-o>dw', 'Remove word after')
map.i('<C-k>', '<esc>vklc', 'Remove above')
map.i('<C-j>', '<C-o>vjhc', 'Remove below')
map.i('<C-Del>', '<C-o>dw', 'Remove word after')
map.i('<C-d>', '<esc>yypi', 'Duplicate line')
map.i('<C-x>', '<C-o>dd', 'Cut line')
map.i('<C-c>', '<C-o>yy', 'Copy line')

-- Pasting
map.v('p', '"_dP', 'Paste without yanking')

map.t('<C-x>', '<C-\\><C-n>', 'Exit terminal mode')

map.n('<C-h>', '<C-w><C-h>', 'Move focus to the left window')
map.n('<C-l>', '<C-w><C-l>', 'Move focus to the right window')
map.n('<C-j>', '<C-w><C-j>', 'Move focus to the lower window')
map.n('<C-k>', '<C-w><C-k>', 'Move focus to the upper window')

map.n('<C-Right>', '<C-w>2>', 'Increase window width')
map.n('<C-Left>', '<C-w>2<', 'Decrease window width')
map.n('<C-Down>', '<C-w>2+', 'Increase window height')
map.n('<C-Up>', '<C-w>2-', 'Decrease window height')

map.n('n', 'nzzzv', 'Next search match')
map.n('N', 'Nzzzv', 'Previous search match')
map.n('-', '/', 'Search')

map.n('H', '0', 'Go to start of line')
map.v('H', '0', 'Go to start of line')
map.n('L', '$', 'Go to end of line')
map.v('L', '$', 'Go to end of line')

map.l_group('v', 'Window')

map.ln('vv', '<C-w>v', 'Split window vertically')
map.ln('vs', '<C-w>s', 'Split window horizontally')
map.ln('vh', '<C-w>H', 'Move window to left')
map.ln('ve', '<C-w>=', 'Equalize window size')

map.ln('vl', '<C-w>L', 'Move window to right')
map.ln('vj', '<C-w>J', 'Move window to bottom')
map.ln('vk', '<C-w>K', 'Move window to top')
map.ln('vh', '<C-w>H', 'Move window to left')

-- Line numbers
map.l_group('n', 'Line Numbers')

map.ln('nn', '<cmd>set invnumber<cr>', 'Toggle line numbers')
map.ln('nr', '<cmd>set invrelativenumber<cr>', 'Toggle relative line numbers')
