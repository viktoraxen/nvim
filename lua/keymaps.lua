-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`
local map = function(mode, key, action, desc)
  vim.keymap.set(mode, key, action, { desc = desc })
end

local map_n = function(key, action, desc)
  map('n', key, action, desc)
end

local map_v = function(key, action, desc)
  map('v', key, action, desc)
end

local map_t = function(key, action, desc)
  map('t', key, action, desc)
end

local map_i = function(key, action, desc)
  map('i', key, action, desc)
end

local leader = function(key, action, desc)
  map_n('<leader>' .. key, action, desc)
end

local group = function(key, desc)
  require('which-key').add { { '<leader>' .. key, group = desc } }
end

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
map_n('<Esc>', '<cmd>nohlsearch<CR>')

-- Basic
leader('q', '<cmd>q<cr>', 'Close buffer')
leader('w', '<cmd>w<cr>', 'Save buffer')
leader('e', '<cmd>Neotree toggle right<cr>', 'Open NTree')

-- Navigation
map_n('<C-d>', '<C-d>zz', 'Scroll half-page down')
map_n('<C-u>', '<C-u>zz', 'Scroll half-page up')
map_n('<C-f>', '<C-f>zz', 'Scroll full-page down')
map_n('<C-b>', '<C-b>zz', 'Scroll full-page up')
map_n('n', 'nzzzv', 'Next search match')
map_n('N', 'Nzzzv', 'Previous search match')

-- Align
map_n('ga', '<Plug>(EasyAlign)', 'Align')
map_v('ga', '<Plug>(EasyAlign)', 'Align')

-- Diagnostic keymaps
group('d', 'Diagnostics')

leader('dk', vim.diagnostic.goto_prev, 'Go to previous diagnostic message')
leader('dj', vim.diagnostic.goto_next, 'Go to next diagnostic message')
leader('df', vim.diagnostic.open_float, 'Open diagnostic Float')
leader('dq', vim.diagnostic.setloclist, 'Open diagnostic quickfix list')
leader('ds', vim.diagnostic.show, 'Show diagnostics')
leader('dt', '<Plug>(toggle-lsp-diag)', 'Toggle diagnostics')
leader('de', '<Plug>(toggle-lsp-diag-default)', 'Enable diagnostics')
leader('dd', '<Plug>(toggle-lsp-diag-off)', 'Disable diagnostics')
leader('dv', '<Plug>(toggle-lsp-diag-vtext)', 'Toggle virtual text')
leader('du', '<Plug>(toggle-lsp-diag-underline)', 'Toggle virtual text')

-- LSP keymaps
map_n('gh', vim.lsp.buf.hover, 'LSP hover documentation')
map_n('gD', vim.lsp.buf.declaration, 'Goto Declaration')

map_n('gt', require('telescope.builtin').lsp_type_definitions, 'Type definition')
map_n('gd', require('telescope.builtin').lsp_definitions, 'Goto definition')
map_n('gr', require('telescope.builtin').lsp_references, 'Goto References')
map_n('gI', require('telescope.builtin').lsp_implementations, 'Goto Implementation')

group('l', 'Language Server')

leader('lc', vim.lsp.buf.code_action, 'Code Action')
leader('lr', vim.lsp.buf.rename, 'Rename')

leader('lw', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Workspace symbols')
leader('ls', require('telescope.builtin').lsp_document_symbols, 'Document symbols')

-- Telescope
group('s', 'Search')

local builtin = require 'telescope.builtin'

leader('s.', builtin.oldfiles, 'Search Recent Files ("." for repeat)')
leader('sc', builtin.colorscheme, 'Colorscheme')
leader('sd', builtin.diagnostics, 'Search Diagnostics')
leader('sf', builtin.find_files, 'Files')
leader('sg', builtin.live_grep, 'Live grep')
leader('sg', builtin.live_grep, 'Search by Grep')
leader('sh', builtin.help_tags, 'Search Help')
leader('sk', builtin.keymaps, 'Search Keymaps')
leader('sm', builtin.man_pages, 'Manual pages')
leader('sr', builtin.resume, 'Search Resume')
leader('ss', builtin.lsp_workspace_symbols, 'Workspace symbols')
leader('st', builtin.builtin, 'Search Select Telescope')
leader('sw', builtin.grep_string, 'Search current Word')
leader('<leader>', builtin.buffers, 'Find existing buffers')

-- Line numbers
group('n', 'Line Numbers')

leader('nn', '<cmd>set invnumber<cr>', 'Toggle line numbers')
leader('nr', '<cmd>set invrelativenumber<cr>', 'Toggle relative line numbers')

-- Insert mode
map_i('jj', '<Esc>', 'Exit insert mode')
map_i('', '<C-w>', 'Ctrl + backspace')
map_i('<C-Del>', '<space><esc>ce', 'Ctrl + delete')

-- Terminal mode
map_t('<Esc><Esc>', '<C-\\><C-n>', 'Exit terminal mode')
map_t('jj', '<C-\\><C-n>', 'Exit terminal mode')

-- Window navigation
map_n('<C-h>', '<C-w><C-h>', 'Move focus to the left window')
map_n('<C-l>', '<C-w><C-l>', 'Move focus to the right window')
map_n('<C-j>', '<C-w><C-j>', 'Move focus to the lower window')
map_n('<C-k>', '<C-w><C-k>', 'Move focus to the upper window')

map_n('<C-Right>', '<C-w>2>', 'Increase window width')
map_n('<C-Left>', '<C-w>2<', 'Decrease window width')
map_n('<C-Down>', '<C-w>2+', 'Increase window height')
map_n('<C-Up>', '<C-w>2-', 'Decrease window height')

group('v', 'Window')

leader('vv', '<C-w>v', 'Split window vertically')
leader('vs', '<C-w>s', 'Split window horizontally')
leader('vh', '<C-w>H', 'Move window to left')
leader('ve', '<C-w>=', 'Equalize window size')

-- Line navigation
map_n('H', '0', 'Go to start of line')
map_v('H', '0', 'Go to start of line')
map_n('L', '$', 'Go to end of line')
map_v('L', '$', 'Go to end of line')
