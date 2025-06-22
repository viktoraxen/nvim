vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true

vim.opt.termguicolors = true
vim.cmd.colorscheme 'catppuccin-mocha'

require 'autocommands'

require 'options'

local map = function(mode, key, action, desc)
    vim.keymap.set(mode, key, action, { desc = desc })
end

local mn = function(key, action, desc)
    map('n', key, action, desc)
end

local mv = function(key, action, desc)
    map('v', key, action, desc)
end

local mi = function(key, action, desc)
    map('i', key, action, desc)
end

local ln = function(key, action, desc)
    mn('<leader>' .. key, action, desc)
end

mn('<Esc>', '<cmd>nohlsearch<cr>', 'Clear search highlight')

-- Basic
ln('q', '<cmd>q<cr>', 'Close buffer')
ln('Q', '<cmd>qa<cr>', 'Close all')
ln('w', '<cmd>w<cr>', 'Save buffer')

-- Visual editing
mv('=', '=gv', 'Auto-indent selection')
mv('>', '>gv', 'Indent selection')
mv('<', '<gv', 'De-indent selection')

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

-- Windows
mn('<C-M-h>', '<C-w><C-h>', 'Move focus to the left window')
mn('<C-M-l>', '<C-w><C-l>', 'Move focus to the right window')
mn('<C-M-j>', '<C-w><C-j>', 'Move focus to the lower window')
mn('<C-M-k>', '<C-w><C-k>', 'Move focus to the upper window')

mn('<C-Right>', '<C-w>2>', 'Increase window width')
mn('<C-Left>', '<C-w>2<', 'Decrease window width')
mn('<C-Down>', '<C-w>2+', 'Increase window height')
mn('<C-Up>', '<C-w>2-', 'Decrease window height')

ln('vv', '<C-w>v', 'Split window vertically')
ln('vs', '<C-w>s', 'Split window horizontally')
ln('vh', '<C-w>H', 'Move window to left')
ln('ve', '<C-w>=', 'Equalize window size')

ln('vl', '<C-w>L', 'Move window to right')
ln('vj', '<C-w>J', 'Move window to bottom')
ln('vk', '<C-w>K', 'Move window to top')
ln('vh', '<C-w>H', 'Move window to left')

-- Navigation
mn('n', 'nzzzv', 'Next search match')
mn('N', 'Nzzzv', 'Previous search match')
mn('-', '/', 'Search')

mn('H', '0', 'Go to start of line')
mv('H', '0', 'Go to start of line')
mn('L', '$', 'Go to end of line')
mv('L', '$', 'Go to end of line')

-- Line numbers
ln('nn', '<cmd>set invnumber<cr>', 'Toggle line numbers')
ln('nr', '<cmd>set invrelativenumber<cr>', 'Toggle relative line numbers')
