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

local leader_group = function(key, desc)
    require('which-key').add { mode = { 'n', 'v' }, { '<leader>' .. key, group = desc } }
end

local group = function(key, desc)
    require('which-key').add { mode = { 'n', 'v' }, { key, group = desc } }
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

-- Line navigation
mn('H', '0', 'Go to start of line')
mv('H', '0', 'Go to start of line')
mn('L', '$', 'Go to end of line')
mv('L', '$', 'Go to end of line')

-- Basic
ln('q', '<cmd>q<cr>', 'Close buffer')
ln('Q', '<cmd>qa<cr>', 'Close all')
ln('w', '<cmd>w<cr>', 'Save buffer')
ln('e', '<cmd>Neotree toggle<cr>', 'Open Neotree')

leader_group('c', 'Co-Pilot')

ln('cc', '<cmd>Copilot toggle<cr>', 'Toggle')
ln('cd', '<cmd>Copilot disable<cr>', 'Disable')
ln('ce', '<cmd>Copilot enable<cr>', 'Enable')

-- LSP keymaps
local show_line_diagnostics = require('helpers.diagnostics').show_current_line_diagnostics

mn('gh', show_line_diagnostics, 'Show line diagnostics')
mn('gj', '<cmd>lua vim.diagnostic.goto_next()<cr>', 'Next diagnostic')
mn('gk', '<cmd>lua vim.diagnostic.goto_prev()<cr>', 'Previous diagnostic')

mn('K', '<cmd>lua require("helpers.lsp").hover()<cr>', 'Hover')

leader_group('l', 'Language Server')
leader_group('p', 'Peek')

group('g', 'Go to')
group('gr', 'LSP Buffer')

mn('gra', '<cmd>lua vim.lsp.buf.code_action()<cr>', 'Code action')
mn('grc', '<cmd>lua vim.lsp.buf.declaration()<cr>', 'Go to declaration')
mn('grd', '<cmd>lua vim.lsp.buf.definition()<cr>', 'Go to definition')
mn('grf', '<cmd>lua vim.lsp.buf.format()<cr>', 'Format buffer')
mn('gri', '<cmd>lua vim.lsp.buf.implementation()<cr>', 'Implementation')
mn('grn', '<cmd>lua vim.lsp.buf.rename()<cr>', 'Rename symbol')
mn('grr', '<cmd>lua vim.lsp.buf.references()<cr>', 'References')
mn('grt', '<cmd>lua vim.lsp.buf.type_definition()<cr>', 'Go to type definition')

ln('lc', '<cmd>lua Snacks.picker.lsp_declarations()<cr>', 'Declarations')
ln('ld', '<cmd>lua Snacks.picker.lsp_definitions()<cr>', 'Definitions')
ln('lr', '<cmd>lua Snacks.picker.lsp_references()<cr>', 'References')
ln('li', '<cmd>lua Snacks.picker.lsp_implementations()<cr>', 'Implementations')
ln('ls', '<cmd>lua Snacks.picker.lsp_symbols()<cr>', 'Symbols')
ln('lt', '<cmd>lua Snacks.picker.lsp_type_definitions()<cr>', 'Type Definitions')
ln('lw', '<cmd>lua Snacks.picker.lsp_workspace_symbols()<cr>', 'Workspace Symbols')

-- Search
leader_group('s', 'Search')

ln('f', '<cmd>lua Snacks.picker.files()<cr>', 'Search files')
ln('ss', '<cmd>lua Snacks.picker.grep()<cr>', 'Grep')
ln('sd', '<cmd>lua Snacks.picker.diagnostics()<cr>', 'Diagnostics')
ln('sf', '<cmd>lua Snacks.picker.files()<cr>', 'Files')
ln('si', '<cmd>lua Snacks.picker.icons()<cr>', 'Icons')
ln('sp', '<cmd>lua Snacks.picker.projects()<cr>', 'Projects')
ln('sP', '<cmd>lua Snacks.picker.pickers()<cr>', 'Pickers')
ln('sr', '<cmd>lua Snacks.picker.resume()<cr>', 'Resume')

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

leader_group('v', 'Window')

ln('vv', '<C-w>v', 'Split window vertically')
ln('vs', '<C-w>s', 'Split window horizontally')
ln('vh', '<C-w>H', 'Move window to left')
ln('ve', '<C-w>=', 'Equalize window size')

ln('vl', '<C-w>L', 'Move window to right')
ln('vj', '<C-w>J', 'Move window to bottom')
ln('vk', '<C-w>K', 'Move window to top')
ln('vh', '<C-w>H', 'Move window to left')

-- Line numbers
leader_group('n', 'Line Numbers')

ln('nn', '<cmd>set invnumber<cr>', 'Toggle line numbers')
ln('nr', '<cmd>set invrelativenumber<cr>', 'Toggle relative line numbers')
