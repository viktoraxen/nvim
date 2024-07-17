-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`
local map = function(mode, key, action, desc)
  vim.keymap.set(mode, key, action, { desc = desc })
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

-- Terminal
local term = require 'FTerm'

mn('<M-3>', term.toggle, 'Toggle terminal')
mi('<M-3>', term.toggle, 'Toggle terminal')
mv('<M-3>', term.toggle, 'Toggle terminal')
mt('<M-3>', term.toggle, 'Toggle terminal')

-- Visual editing
mv('=', '=gv', 'Auto-indent selection')
mv('>', '>gv', 'Indent selection')
mv('<', '<gv', 'De-indent selection')

-- Moving lines
mn('<M-j>', ':m .+1<CR>==', 'Move line down')
mi('<M-j>', '<Esc>:m .+1<CR>==gi', 'Move line down')
mi('<M-k>', '<Esc>:m .-2<CR>==gi', 'Move line up')
mv('<M-j>', ":m '>+1<CR>gv=gv", 'Move selection down')
mn('<M-k>', ':m .-2<CR>==', 'Move line up')
mv('<M-k>', ":m '<-2<CR>gv=gv", 'Move selection up')

-- Basic
ln('q', '<cmd>q<cr>', 'Close buffer')
ln('Q', '<cmd>qa<cr>', 'Close all')
ln('w', '<cmd>w<cr>', 'Save buffer')
ln('e', '<cmd>Neotree toggle right<cr>', 'Open Neotree')

-- Spider
mn('e', "<cmd>lua require('spider').motion('e')<cr>", 'End of word')
mv('e', "<cmd>lua require('spider').motion('e')<cr>", 'End of word')
mn('w', "<cmd>lua require('spider').motion('w')<cr>", 'Start of next word')
mv('w', "<cmd>lua require('spider').motion('w')<cr>", 'Start of next word')
mn('b', "<cmd>lua require('spider').motion('b')<cr>", 'Start of previous word')
mv('b', "<cmd>lua require('spider').motion('b')<cr>", 'Start of previous word')

mn('E', 'e', 'End of word')
mv('E', 'e', 'End of word')
mn('W', 'w', 'Start of next word')
mv('W', 'w', 'Start of next word')
mn('B', 'b', 'Start of previous word')
mv('B', 'b', 'Start of previous word')

-- Debugging
group('b', 'Debug')

local dap = require 'dap'
local dapui = require 'dapui'
local set_breakpoint = function()
  dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
end
local start_debug = function()
  if vim.bo.filetype == 'ruby' then
    vim.fn.setenv('RUBYOPT', '-rdebug/open')
  end

  dap.continue()
end

ln('bj', dap.step_into, 'Step Into')
ln('bh', dap.step_back, 'Step Back')
ln('bl', dap.step_over, 'Step Over')
ln('bk', dap.step_out, 'Step Out')

ln('bc', start_debug, 'Start/Continue')
ln('bq', dap.terminate, 'Terminate')
ln('b.', dap.run_last, 'Run last')
ln('br', dap.run_to_cursor, 'Run to cursor')
ln('bR', dap.restart, 'Restart session')
ln('bt', dapui.toggle, 'See last session result.')

ln('bb', dap.toggle_breakpoint, 'Toggle Breakpoint')
ln('bC', dap.clear_breakpoints, 'Clear Breakpoint')
ln('bB', set_breakpoint, 'Set Breakpoint')

-- Neotree
group('t', 'Neotree')

ln('ts', '<cmd>Neotree document_symbols<cr>', 'Neotree document symbols')
ln('td', '<cmd>Neotree diagnostics<cr>', 'Neotree diagnostics')

-- Navigation
mn('n', 'nzzzv', 'Next search match')
mn('N', 'Nzzzv', 'Previous search match')

-- Align
mn('ga', '<Plug>(EasyAlign)', 'Align')
mv('ga', '<Plug>(EasyAlign)', 'Align')

-- Diagnostic keymaps
group('d', 'Diagnostics')

ln('dk', vim.diagnostic.goto_prev, 'Go to previous diagnostic message')
ln('dj', vim.diagnostic.goto_next, 'Go to next diagnostic message')
ln('df', vim.diagnostic.open_float, 'Open diagnostic Float')
ln('dq', vim.diagnostic.setloclist, 'Open diagnostic quickfix list')
ln('ds', vim.diagnostic.show, 'Show diagnostics')
ln('dt', '<Plug>(toggle-lsp-diag)', 'Toggle diagnostics')
ln('de', '<Plug>(toggle-lsp-diag-default)', 'Enable diagnostics')
ln('dd', '<Plug>(toggle-lsp-diag-off)', 'Disable diagnostics')
ln('dv', '<Plug>(toggle-lsp-diag-vtext)', 'Toggle virtual text')
ln('du', '<Plug>(toggle-lsp-diag-underline)', 'Toggle virtual text')

-- LSP keymaps
vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = 'single',
})
mn('gh', vim.lsp.buf.hover, 'LSP hover documentation')
mn('gD', vim.lsp.buf.declaration, 'Goto Declaration')

mn('gt', require('telescope.builtin').lsp_type_definitions, 'Type definition')
mn('gd', require('telescope.builtin').lsp_definitions, 'Goto definition')
mn('gr', require('telescope.builtin').lsp_references, 'Goto References')
mn('gI', require('telescope.builtin').lsp_implementations, 'Goto Implementation')

group('l', 'Language Server')

local format_buffer = function()
  require('conform').format { async = true, lsp_fallback = true }
end

ln('lc', vim.lsp.buf.code_action, 'Code Action')
ln('lr', vim.lsp.buf.rename, 'Rename')

ln('lw', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Workspace symbols')
ln('ls', require('telescope.builtin').lsp_document_symbols, 'Document symbols')

ln('lf', format_buffer, 'Format buffer')

-- Telescope
group('s', 'Search')

local tsc_bin = require 'telescope.builtin'

ln('s.', tsc_bin.oldfiles, 'Search Recent Files ("." for repeat)')
ln('sc', tsc_bin.colorscheme, 'Colorscheme')
ln('sd', tsc_bin.diagnostics, 'Search Diagnostics')
ln('f', tsc_bin.find_files, 'Files')
ln('sf', tsc_bin.find_files, 'Files')
ln('sg', tsc_bin.live_grep, 'Live grep')
ln('sh', tsc_bin.help_tags, 'Search Help')
ln('sk', tsc_bin.keymaps, 'Search Keymaps')
ln('sl', tsc_bin.highlights, 'Search Highlights')
ln('sm', tsc_bin.man_pages, 'Manual pages')
ln('sr', tsc_bin.resume, 'Search Resume')
ln('ss', tsc_bin.lsp_workspace_symbols, 'Workspace symbols')
ln('st', tsc_bin.builtin, 'Search Select Telescope')
ln('sw', tsc_bin.grep_string, 'Search current Word')
ln('<leader>', tsc_bin.buffers, 'Find existing buffers')

-- Line numbers
group('n', 'Line Numbers')

ln('nn', '<cmd>set invnumber<cr>', 'Toggle line numbers')
ln('nr', '<cmd>set invrelativenumber<cr>', 'Toggle relative line numbers')

-- Insert mode
mi('jj', '<Esc>', 'Exit insert mode')
mi('<C-h>', '<C-w>', 'Remove word before')
mi('<C-l>', '<C-o>dw', 'Remove word after')
mi('<C-k>', '<esc>vklc', 'Remove above')
mi('<C-j>', '<C-o>vjhc', 'Remove below')
mi('<C-Del>', '<C-o>dw', 'Remove word after')

-- Pasting
mv('p', '"_dP', 'Paste without yanking')

-- Terminal mode
mt('<Esc><Esc>', '<C-\\><C-n>', 'Exit terminal mode')
mt('jj', '<C-\\><C-n>', 'Exit terminal mode')

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

-- Harpoon
group('h', 'Harpoon')

ln('ha', require('harpoon.mark').add_file, 'Add file to Harpoon')
ln('hh', require('harpoon.ui').toggle_quick_menu, 'Toggle Harpoon menu')
ln('hj', require('harpoon.ui').nav_next, 'Navigate to next file in Harpoon')
ln('hk', require('harpoon.ui').nav_prev, 'Navigate to previous file in Harpoon')

-- Gitsigns
group('g', 'Git')
local gitsigns = require 'gitsigns'
-- Navigation
ln('gj', function()
  if vim.wo.diff then
    vim.cmd.normal { ' gj', bang = true }
  else
    gitsigns.nav_hunk 'next'
  end
end, 'Jump to next git change')

ln('gk', function()
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
lv('gs', stage_marked, 'stage git hunk')
lv('gr', reset_marked, 'reset git hunk')

-- normal mode
ln('gs', gitsigns.stage_hunk, 'Stage hunk')
ln('gr', gitsigns.reset_hunk, 'Reset hunk')
ln('gS', gitsigns.stage_buffer, 'Stage buffer')
ln('gu', gitsigns.undo_stage_hunk, 'Undo stage hunk')
ln('gR', gitsigns.reset_buffer, 'Reset buffer')
ln('gp', gitsigns.preview_hunk, 'Preview hunk')
ln('gb', gitsigns.blame_line, 'Blame line')
ln('gd', gitsigns.diffthis, 'Diff against index')
ln('gD', diff_commit, 'Diff against last commit')

-- Toggle
group('gt', 'Toggle')

ln('gtb', gitsigns.toggle_current_line_blame, 'Show blame line')
ln('gtd', gitsigns.toggle_deleted, 'Show deleted')

-- Line navigation
mn('H', '0', 'Go to start of line')
mv('H', '0', 'Go to start of line')
mn('L', '$', 'Go to end of line')
mv('L', '$', 'Go to end of line')
