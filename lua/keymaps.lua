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

-- Info
group('i', 'Info')

ln('il', '<cmd>:LspInfo<cr>', 'LSP')
ln('ip', '<cmd>:Lazy<cr>', 'Plugins')
ln('im', '<cmd>:Mason<cr>', 'Mason')

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
mn('-', '/', 'Search')

-- Align
mn('ga', '<Plug>(EasyAlign)', 'Align')
mv('ga', '<Plug>(EasyAlign)', 'Align')

-- Diagnostic keymaps
group('d', 'Diagnostics')

ln('dk', '<cmd>Lspsaga diagnostic_jump_prev<cr>', 'Go to previous diagnostic message')
ln('dj', '<cmd>Lspsaga diagnostic_jump_next<cr>', 'Go to next diagnostic message')
ln('dq', vim.diagnostic.setloclist, 'Open diagnostic quickfix list')
mn('gh', '<cmd>Lspsaga diagnostic_jump_next<cr>', 'Open diagnostic Float')

-- LSP keymaps
vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = 'single',
})
mn('gD', vim.lsp.buf.declaration, 'Goto Declaration')

mn('gt', '<cmd>Lspsaga peek_type_definition<cr>', 'Peek type definition')
mn('gd', '<cmd>Lspsaga peek_definition<cr>', 'Peek definition')
mn('gr', require('telescope.builtin').lsp_references, 'Goto References')
mn('gI', require('telescope.builtin').lsp_implementations, 'Goto Implementation')

group('l', 'Language Server')

local format_buffer = function()
  require('conform').format { async = true, lsp_fallback = true }
end

ln('la', '<cmd>Lspsaga code_action<cr>', 'Code actions')
ln('lf', '<cmd>Lspsaga finder<cr>', 'Find references')
ln('li', '<cmd>Lspsaga incoming_calls<cr>', 'Incoming calls')
ln('lI', '<cmd>Lspsaga finder imp<cr>', 'Find implementations')
ln('ll', '<cmd>Lspsaga outline<cr>', 'Outline')
ln('lo', '<cmd>Lspsaga outgoing_calls<cr>', 'Outgoing calls')
ln('lr', '<cmd>Lspsaga rename<cr>', 'Rename')
ln('ls', require('telescope.builtin').lsp_document_symbols, 'Document symbols')
ln('lw', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Workspace symbols')

ln('lF', format_buffer, 'Format buffer')

-- Telescope
group('s', 'Search')

local tele = require 'telescope.builtin'

ln('f', tele.find_files, 'Files')
ln('s.', tele.oldfiles, 'Search Recent Files ("." for repeat)')
ln('sc', tele.colorscheme, 'Colorscheme')
ln('sd', tele.diagnostics, 'Search Diagnostics')
ln('sf', tele.find_files, 'Files')
ln('sg', tele.live_grep, 'Live grep')
ln('sh', tele.help_tags, 'Search Help')
ln('sk', tele.keymaps, 'Search Keymaps')
ln('sl', tele.highlights, 'Search Highlights')
ln('sm', tele.man_pages, 'Manual pages')
ln('sp', '<cmd>Telescope neovim-project discover<cr>', 'Projects')
ln('sr', tele.resume, 'Search Resume')
ln('ss', tele.lsp_workspace_symbols, 'Workspace symbols')
ln('st', tele.builtin, 'Search Select Telescope')
ln('sw', tele.grep_string, 'Search current Word')

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

-- Copilot
group('c', 'Copilot')

ln('cd', '<cmd>Copilot disable<cr>', 'Disable')
ln('ce', '<cmd>Copilot enable<cr>', 'Enable')
