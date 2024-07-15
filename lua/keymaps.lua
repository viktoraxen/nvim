-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`
local map = function(mode, key, action, desc)
  vim.keymap.set(mode, key, action, { desc = desc })
end

local mp_n = function(key, action, desc)
  map('n', key, action, desc)
end

local mp_v = function(key, action, desc)
  map('v', key, action, desc)
end

local mp_t = function(key, action, desc)
  map('t', key, action, desc)
end

local mp_i = function(key, action, desc)
  map('i', key, action, desc)
end

local ld_n = function(key, action, desc)
  mp_n('<leader>' .. key, action, desc)
end

local ld_v = function(key, action, desc)
  mp_v('<leader>' .. key, action, desc)
end

local group = function(key, desc)
  require('which-key').add { mode = { 'n', 'v' }, { '<leader>' .. key, group = desc } }
end

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
mp_n('<Esc>', '<cmd>nohlsearch<CR>')

-- Terminal
local term = require 'FTerm'

ld_n('f', term.toggle, 'Toggle terminal')

-- Visual editing
mp_v('=', '=gv', 'Auto-indent selection')
mp_v('>', '>gv', 'Indent selection')
mp_v('<', '<gv', 'De-indent selection')

-- Moving lines
mp_n('<M-j>', ':m .+1<CR>==', 'Move line down')
mp_i('<M-j>', '<Esc>:m .+1<CR>==gi', 'Move line down')
mp_i('<M-k>', '<Esc>:m .-2<CR>==gi', 'Move line up')
mp_v('<M-j>', ":m '>+1<CR>gv=gv", 'Move selection down')
mp_n('<M-k>', ':m .-2<CR>==', 'Move line up')
mp_v('<M-k>', ":m '<-2<CR>gv=gv", 'Move selection up')
-- Basic
ld_n('q', '<cmd>q<cr>', 'Close buffer')
ld_n('Q', '<cmd>qa<cr>', 'Close all')
ld_n('w', '<cmd>w<cr>', 'Save buffer')
ld_n('e', '<cmd>Neotree toggle right<cr>', 'Open Neotree')

-- Neotree
group('t', 'Neotree')

ld_n('ts', '<cmd>Neotree document_symbols<cr>', 'Neotree document symbols')
ld_n('td', '<cmd>Neotree diagnostics<cr>', 'Neotree diagnostics')

-- Navigation
-- mp_n('<C-d>', '<C-d>zz', 'Scroll half-page down')
-- mp_n('<C-u>', '<C-u>zz', 'Scroll half-page up')
-- mp_n('<C-f>', '<C-f>zz', 'Scroll full-page down')
-- mp_n('<C-b>', '<C-b>zz', 'Scroll full-page up')
mp_n('n', 'nzzzv', 'Next search match')
mp_n('N', 'Nzzzv', 'Previous search match')

-- Align
mp_n('ga', '<Plug>(EasyAlign)', 'Align')
mp_v('ga', '<Plug>(EasyAlign)', 'Align')

-- Diagnostic keymaps
group('d', 'Diagnostics')

ld_n('dk', vim.diagnostic.goto_prev, 'Go to previous diagnostic message')
ld_n('dj', vim.diagnostic.goto_next, 'Go to next diagnostic message')
ld_n('df', vim.diagnostic.open_float, 'Open diagnostic Float')
ld_n('dq', vim.diagnostic.setloclist, 'Open diagnostic quickfix list')
ld_n('ds', vim.diagnostic.show, 'Show diagnostics')
ld_n('dt', '<Plug>(toggle-lsp-diag)', 'Toggle diagnostics')
ld_n('de', '<Plug>(toggle-lsp-diag-default)', 'Enable diagnostics')
ld_n('dd', '<Plug>(toggle-lsp-diag-off)', 'Disable diagnostics')
ld_n('dv', '<Plug>(toggle-lsp-diag-vtext)', 'Toggle virtual text')
ld_n('du', '<Plug>(toggle-lsp-diag-underline)', 'Toggle virtual text')

-- LSP keymaps
vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = 'single',
})
mp_n('gh', vim.lsp.buf.hover, 'LSP hover documentation')
mp_n('gD', vim.lsp.buf.declaration, 'Goto Declaration')

mp_n('gt', require('telescope.builtin').lsp_type_definitions, 'Type definition')
mp_n('gd', require('telescope.builtin').lsp_definitions, 'Goto definition')
mp_n('gr', require('telescope.builtin').lsp_references, 'Goto References')
mp_n('gI', require('telescope.builtin').lsp_implementations, 'Goto Implementation')

group('l', 'Language Server')

local format_buffer = function()
  require('conform').format { async = true, lsp_fallback = true }
end

ld_n('lc', vim.lsp.buf.code_action, 'Code Action')
ld_n('lr', vim.lsp.buf.rename, 'Rename')

ld_n('lw', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Workspace symbols')
ld_n('ls', require('telescope.builtin').lsp_document_symbols, 'Document symbols')

ld_n('lf', format_buffer, 'Format buffer')

-- Telescope
group('s', 'Search')

local tsc_bin = require 'telescope.builtin'

ld_n('s.', tsc_bin.oldfiles, 'Search Recent Files ("." for repeat)')
ld_n('sc', tsc_bin.colorscheme, 'Colorscheme')
ld_n('sd', tsc_bin.diagnostics, 'Search Diagnostics')
ld_n('sf', tsc_bin.find_files, 'Files')
ld_n('sg', tsc_bin.live_grep, 'Live grep')
ld_n('sg', tsc_bin.live_grep, 'Search by Grep')
ld_n('sh', tsc_bin.help_tags, 'Search Help')
ld_n('sk', tsc_bin.keymaps, 'Search Keymaps')
ld_n('sm', tsc_bin.man_pages, 'Manual pages')
ld_n('sr', tsc_bin.resume, 'Search Resume')
ld_n('ss', tsc_bin.lsp_workspace_symbols, 'Workspace symbols')
ld_n('st', tsc_bin.builtin, 'Search Select Telescope')
ld_n('sw', tsc_bin.grep_string, 'Search current Word')
ld_n('<leader>', tsc_bin.buffers, 'Find existing buffers')

-- Line numbers
group('n', 'Line Numbers')

ld_n('nn', '<cmd>set invnumber<cr>', 'Toggle line numbers')
ld_n('nr', '<cmd>set invrelativenumber<cr>', 'Toggle relative line numbers')

-- Insert mode
mp_i('jj', '<Esc>', 'Exit insert mode')
mp_i('<C-BS>', '<cmd>echo hello<cr>', 'Ctrl + backspace')
mp_i('<C-Del>', '<space><esc>ce', 'Ctrl + delete')

-- Terminal mode
mp_t('<Esc><Esc>', '<C-\\><C-n>', 'Exit terminal mode')
mp_t('jj', '<C-\\><C-n>', 'Exit terminal mode')

-- Window navigation
mp_n('<C-h>', '<C-w><C-h>', 'Move focus to the left window')
mp_n('<C-l>', '<C-w><C-l>', 'Move focus to the right window')
mp_n('<C-j>', '<C-w><C-j>', 'Move focus to the lower window')
mp_n('<C-k>', '<C-w><C-k>', 'Move focus to the upper window')

mp_n('<C-Right>', '<C-w>2>', 'Increase window width')
mp_n('<C-Left>', '<C-w>2<', 'Decrease window width')
mp_n('<C-Down>', '<C-w>2+', 'Increase window height')
mp_n('<C-Up>', '<C-w>2-', 'Decrease window height')

group('v', 'Window')

ld_n('vv', '<C-w>v', 'Split window vertically')
ld_n('vs', '<C-w>s', 'Split window horizontally')
ld_n('vh', '<C-w>H', 'Move window to left')
ld_n('ve', '<C-w>=', 'Equalize window size')

-- Gitsigns
group('g', 'Git')
local gitsigns = require 'gitsigns'
-- Navigation
ld_n('gj', function()
  if vim.wo.diff then
    vim.cmd.normal { ' gj', bang = true }
  else
    gitsigns.nav_hunk 'next'
  end
end, 'Jump to next git change')

ld_n('gk', function()
  if vim.wo.diff then
    vim.cmd.normal { 'gk', bang = true }
  else
    gitsigns.nav_hunk 'prev'
  end
end, 'Jump to previous git change')

-- Actions
local stage_marked = function()
  gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
end

local reset_marked = function()
  gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
end

local diff_commit = function()
  gitsigns.diffthis '@'
end

-- visual mode
ld_v('gs', stage_marked, 'stage git hunk')
ld_v('gr', reset_marked, 'reset git hunk')

-- normal mode
ld_n('gs', gitsigns.stage_hunk, 'Stage hunk')
ld_n('gr', gitsigns.reset_hunk, 'Reset hunk')
ld_n('gS', gitsigns.stage_buffer, 'Stage buffer')
ld_n('gu', gitsigns.undo_stage_hunk, 'Undo stage hunk')
ld_n('gR', gitsigns.reset_buffer, 'Reset buffer')
ld_n('gp', gitsigns.preview_hunk, 'Preview hunk')
ld_n('gb', gitsigns.blame_line, 'Blame line')
ld_n('gd', gitsigns.diffthis, 'Diff against index')
ld_n('gD', diff_commit, 'Diff against last commit')

-- Toggle
group('gt', 'Toggle')

ld_n('gtb', gitsigns.toggle_current_line_blame, 'Show blame line')
ld_n('gtd', gitsigns.toggle_deleted, 'Show deleted')

-- Line navigation
mp_n('H', '0', 'Go to start of line')
mp_v('H', '0', 'Go to start of line')
mp_n('L', '$', 'Go to end of line')
mp_v('L', '$', 'Go to end of line')
