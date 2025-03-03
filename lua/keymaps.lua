local map = function(mode, key, action, desc)
    vim.keymap.set(mode, key, action, { desc = desc })
end

local mo = function(key, action, desc)
    map('o', key, action, desc)
end

local mn = function(key, action, desc)
    map('n', key, action, desc)
end

local mv = function(key, action, desc)
    map('v', key, action, desc)
end

local mt = function(key, action, desc)
    map('t', key, action, desc)
end

local mi = function(key, action, desc)
    map('i', key, action, desc)
end

local ln = function(key, action, desc)
    mn('<leader>' .. key, action, desc)
end

local lv = function(key, action, desc)
    mv('<leader>' .. key, action, desc)
end

local group = function(key, desc)
    require('which-key').add { mode = { 'n', 'v' }, { '<leader>' .. key, group = desc } }
end

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
mn('<Esc>', '<cmd>nohlsearch<CR>')

ln('A', '<cmd>Alpha<cr>', 'Alpha')

-- Visual editing
mv('=', '=gv', 'Auto-indent selection')
mv('>', '>gv', 'Indent selection')
mv('<', '<gv', 'De-indent selection')
-- mv('gc', 'gcgv', 'Comment selection')
-- mv('gb', 'gbgv', 'Comment selection block')

-- Moving lines
mn('<M-j>', ':m .+1<CR>==', 'Move line down')
mi('<M-j>', '<Esc>:m .+1<CR>==gi', 'Move line down')
mi('<M-k>', '<Esc>:m .-2<CR>==gi', 'Move line up')
mv('<M-j>', ":m '>+1<CR>gv=gv", 'Move selection down')
mn('<M-k>', ':m .-2<CR>==', 'Move line up')
mv('<M-k>', ":m '<-2<CR>gv=gv", 'Move selection up')

-- Line navigation
mn('H', '0', 'Go to start of line')
mv('H', '0', 'Go to start of line')
mn('L', '$', 'Go to end of line')
mv('L', '$', 'Go to end of line')

-- Basic
ln('q', '<cmd>q<cr>', 'Close buffer')
ln('Q', '<cmd>qa<cr>', 'Close all')
ln('w', '<cmd>w<cr>', 'Save buffer')
ln('e', '<cmd>Neotree toggle right<cr>', 'Open Neotree')

-- LSP keymaps
vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = 'single',
})

mn('gD', vim.lsp.buf.declaration, 'Goto Declaration')
mn('gt', '<cmd>lua vim.lsp.buf.type_definition()<cr>', 'Go to type definition')
mn('gd', '<cmd>lua vim.lsp.buf.definition()<cr>', 'Go to definition')
mn('gh', '<cmd>lua vim.diagnostic.open_float(nil, { border = "single" })<cr>', 'Open diagnostic Float')

group('l', 'Language Server')
group('p', 'Peek')

local format_buffer = function()
    require('conform').format { async = true, lsp_fallback = true }
end

ln('lF', format_buffer, 'Format buffer')
ln('lr', '<cmd>lua require("renamer").rename()<cr>', 'Rename symbol')

-- Search
group('s', 'Search')

ln('ss', '<cmd>lua Snacks.picker.grep()<cr>', 'Search in project')
ln('sf', '<cmd>lua Snacks.picker.files()<cr>', 'Search files')
ln('sp', '<cmd>lua Snacks.picker.projects()<cr>', 'Search projects')
ln('sr', '<cmd>lua Snacks.picker.resume()<cr>', 'Resume search')

-- Spider
mn('e', "<cmd>lua require('spider').motion('e')<cr>", 'End of word')
mv('e', "<cmd>lua require('spider').motion('e')<cr>", 'End of word')
mo('e', "<cmd>lua require('spider').motion('e')<cr>", 'End of word')
mn('w', "<cmd>lua require('spider').motion('w')<cr>", 'Start of next word')
mv('w', "<cmd>lua require('spider').motion('w')<cr>", 'Start of next word')
mo('w', "<cmd>lua require('spider').motion('w')<cr>", 'Start of next word')
mn('b', "<cmd>lua require('spider').motion('b')<cr>", 'Start of previous word')
mv('b', "<cmd>lua require('spider').motion('b')<cr>", 'Start of previous word')
mo('b', "<cmd>lua require('spider').motion('b')<cr>", 'Start of previous word')

mn('E', 'e', 'End of word')
mv('E', 'e', 'End of word')
mn('W', 'w', 'Start of next word')
mv('W', 'w', 'Start of next word')
mn('B', 'b', 'Start of previous word')
mv('B', 'b', 'Start of previous word')

-- Navigation
mn('n', 'nzzzv', 'Next search match')
mn('N', 'Nzzzv', 'Previous search match')
mn('-', '/', 'Search')

-- Align
mn('ga', '<Plug>(EasyAlign)', 'Align')
mv('ga', '<Plug>(EasyAlign)', 'Align')

-- Copy
mn('yA', 'ggVGy', 'Copy all')
mn('vA', 'ggVG', 'Select all')
mn('dA', 'ggVGd', 'Delete all')
mn('cA', 'ggVGc', 'Change all')

-- Insert mode
mi('jj', '<Esc>', 'Exit insert mode')
mi('<C-h>', '<C-w>', 'Remove word before')
mi('<C-l>', '<C-o>dw', 'Remove word after')
mi('<C-k>', '<esc>vklc', 'Remove above')
mi('<C-j>', '<C-o>vjhc', 'Remove below')
mi('<C-Del>', '<C-o>dw', 'Remove word after')
mi('<C-d>', '<esc>yypi', 'Duplicate line')
mi('<C-x>', '<C-o>dd', 'Cut line')
mi('<C-c>', '<C-o>yy', 'Copy line')

-- Pasting
mv('p', '"_dP', 'Paste without yanking')

-- Terminal

mn('<M-2>', '<cmd>ToggleTerm direction=vertical<cr>', 'Toggle terminal')
mi('<M-2>', '<cmd>ToggleTerm direction=vertical<cr>', 'Toggle terminal')
mv('<M-2>', '<cmd>ToggleTerm direction=vertical<cr>', 'Toggle terminal')
mt('<M-2>', '<cmd>ToggleTerm direction=vertical<cr>', 'Toggle terminal')

mn('<M-3>', '<cmd>ToggleTerm direction=float<cr>', 'Toggle terminal')
mi('<M-3>', '<cmd>ToggleTerm direction=float<cr>', 'Toggle terminal')
mv('<M-3>', '<cmd>ToggleTerm direction=float<cr>', 'Toggle terminal')
mt('<M-3>', '<cmd>ToggleTerm direction=float<cr>', 'Toggle terminal')

mt('<C-x>', '<C-\\><C-n>', 'Exit terminal mode')

-- Window navigation
mn('<C-h>', '<C-w><C-h>', 'Move focus to the left window')
mn('<C-l>', '<C-w><C-l>', 'Move focus to the right window')
mn('<C-j>', '<C-w><C-j>', 'Move focus to the lower window')
mn('<C-k>', '<C-w><C-k>', 'Move focus to the upper window')

mn('<C-Right>', '<C-w>2>', 'Increase window width')
mn('<C-Left>', '<C-w>2<', 'Decrease window width')
mn('<C-Down>', '<C-w>2+', 'Increase window height')
mn('<C-Up>', '<C-w>2-', 'Decrease window height')

group('v', 'Window')

ln('vv', '<C-w>v', 'Split window vertically')
ln('vs', '<C-w>s', 'Split window horizontally')
ln('vh', '<C-w>H', 'Move window to left')
ln('ve', '<C-w>=', 'Equalize window size')

ln('vl', '<C-w>L', 'Move window to right')
ln('vj', '<C-w>J', 'Move window to bottom')
ln('vk', '<C-w>K', 'Move window to top')
ln('vh', '<C-w>H', 'Move window to left')

-- Line numbers
group('n', 'Line Numbers')

ln('nn', '<cmd>set invnumber<cr>', 'Toggle line numbers')
ln('nr', '<cmd>set invrelativenumber<cr>', 'Toggle relative line numbers')
