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

local leader_group = function(key, desc)
    require('which-key').add { mode = { 'n', 'v' }, { '<leader>' .. key, group = desc } }
end

local group = function(key, desc)
    require('which-key').add { mode = { 'n', 'v' }, { key, group = desc } }
end

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
local clear_hl_and_notifications = function()
    vim.cmd('nohlsearch')
    Snacks.notifier.hide()
end
mn('<Esc>', clear_hl_and_notifications, 'Clear search highlight and notifications')

local run = require('utils.run')

leader_group('r', 'Run')
ln('rr', run.run_current, 'Run Current')
ln('rd', run.debug_current, 'Debug Current')

leader_group('d', 'Debug')
ln('dd', run.debug_current, 'Debug Current')

local cmake = require('utils.cpp.cmake')

local cmake_generate_debug = function() cmake.generate(true) end
local cmake_clean_generate_debug = function() cmake.clean_generate(true) end
local cmake_clean_build_debug = function() cmake.clean_build(true) end

leader_group('c', 'CMake')
ln('cC', cmake.clean, 'Clean')

leader_group('cg', 'Generate')
ln('cgg', cmake.generate, 'Generate CMake files (Release)')
ln('cgG', cmake.clean_generate, 'Clean and generate CMake files (Release)')
ln('cgd', cmake_generate_debug, 'Generate CMake files (Debug)')
ln('cgD', cmake_clean_generate_debug, 'Clean and generate CMake files (Debug)')

leader_group('cb', 'Build')
ln('cbb', cmake.build, 'Build CMake project')
ln('cbB', cmake.clean_build, 'Clean and build CMake project (Release)')
ln('cbD', cmake_clean_build_debug, 'Clean and build CMake project (Debug)')

leader_group('cr', 'Run')
ln('crr', cmake.build_and_run_float, 'Run CMake project')
ln('crR', cmake.clean_run_float, 'Clean and run CMake project (Release)')
ln('crd', cmake.build_and_run_debug, 'Run CMake project (Debug)')
ln('crD', cmake.clean_run_debugger, 'Clean and debug CMake project')

ln('A', '<cmd>Alpha<cr>', 'Alpha')

-- Leap
mn('s', '<Plug>(leap)', 'Leap')
mv('s', '<Plug>(leap)', 'Leap')
mo('s', '<Plug>(leap)', 'Leap')

-- Visual editing
mv('=', '=gv', 'Auto-indent selection')
mv('>', '>gv', 'Indent selection')
mv('<', '<gv', 'De-indent selection')

-- Basic
ln('q', '<cmd>q<cr>', 'Close buffer')
ln('Q', '<cmd>qa<cr>', 'Close all')
ln('w', '<cmd>w<cr>', 'Save buffer')
ln('e', '<cmd>Neotree toggle<cr>', 'Open Neotree')

-- CoPilot
leader_group('p', 'CoPilot')

ln('pc', '<cmd>Copilot toggle<cr>', 'Toggle')
ln('pd', '<cmd>Copilot disable<cr>', 'Disable')
ln('pe', '<cmd>Copilot enable<cr>', 'Enable')

-- Git
leader_group('g', 'Git')
ln('gg', '<cmd>lua Snacks.lazygit()<cr>', 'Lazygit')

-- LSP keymaps
local show_line_diagnostics = require('utils.diagnostics').show_current_line_diagnostics

mn('gh', show_line_diagnostics, 'Show line diagnostics')
mn('gj', '<cmd>lua vim.diagnostic.goto_next()<cr>', 'Next diagnostic')
mn('gk', '<cmd>lua vim.diagnostic.goto_prev()<cr>', 'Previous diagnostic')

mn('K', require("utils.lsp").hover, 'Hover')

leader_group('l', 'Language Server')
leader_group('p', 'Peek')

group('g', 'Go to')
group('gr', 'LSP Buffer')

mn('gra', '<cmd>lua vim.lsp.buf.code_action()<cr>', 'Code action')
mn('grc', '<cmd>lua Snacks.picker.lsp_declarations()<cr>', 'Go to declaration')
mn('grd', '<cmd>lua Snacks.picker.lsp_definitions()<cr>', 'Go to definition')
mn('grf', '<cmd>lua vim.lsp.buf.format()<cr>', 'Format buffer')
mn('gri', '<cmd>lua Snacks.picker.lsp_implementation()<cr>', 'Implementation')
mn('grn', '<cmd>lua vim.lsp.buf.rename()<cr>', 'Rename symbol')
mn('grr', '<cmd>lua Snacks.picker.lsp_references()<cr>', 'References')
mn('grt', '<cmd>lua Snacks.picker.lsp_type_definitions()<cr>', 'Go to type definition')

ln('lc', '<cmd>lua Snacks.picker.lsp_declarations()<cr>', 'Declarations')
ln('ld', '<cmd>lua Snacks.picker.lsp_definitions()<cr>', 'Definitions')
ln('li', '<cmd>lua Snacks.picker.lsp_implementations()<cr>', 'Implementations')
ln('lr', '<cmd>lua Snacks.picker.lsp_references()<cr>', 'References')
ln('ls', '<cmd>lua Snacks.picker.lsp_symbols()<cr>', 'Symbols')
ln('lt', '<cmd>lua Snacks.picker.lsp_type_definitions()<cr>', 'Type Definitions')
ln('lw', '<cmd>lua Snacks.picker.lsp_workspace_symbols()<cr>', 'Workspace Symbols')

-- Search
leader_group('s', 'Search')

ln('f', require('utils.pickers').open_files_vscode, 'Search files')
ln('ss', '<cmd>lua Snacks.picker.grep()<cr>', 'Grep')
ln('sg', '<cmd>lua Snacks.picker.git_files()<cr>', 'Grep string')
ln('sd', '<cmd>lua Snacks.picker.diagnostics()<cr>', 'Diagnostics')
ln('sf', '<cmd>lua Snacks.picker.files()<cr>', 'Files')
ln('sF', '<cmd>lua Snacks.picker.files({hidden = true, ignored = true, follow = true})<cr>', 'Files')
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

mn('<M-3>', '<cmd>lua Snacks.terminal()<cr>', 'Toggle terminal')
mi('<M-3>', '<cmd>lua Snacks.terminal()<cr>', 'Toggle terminal')
mv('<M-3>', '<cmd>lua Snacks.terminal()<cr>', 'Toggle terminal')
mt('<M-3>', '<cmd>lua Snacks.terminal()<cr>', 'Toggle terminal')

ln('t', '<cmd>lua Snacks.terminal()<cr>', 'Toggle terminal')

mt('<C-x>', '<C-\\><C-n>', 'Exit terminal mode')

-- Navigation
mn('<C-h>', '<cmd>Treewalker Left<cr>', 'Treewalker Left')
mn('<C-l>', '<cmd>Treewalker Right<cr>', 'Treewalker Right')
mn('<C-j>', '<cmd>Treewalker Down<cr>', 'Treewalker Down')
mn('<C-k>', '<cmd>Treewalker Up<cr>', 'Treewalker Up')

mn('<C-S-h>', '<cmd>Treewalker SwapLeft<cr>', 'Treewalker Swap Left')
mn('<C-S-l>', '<cmd>Treewalker SwapRight<cr>', 'Treewalker Swap Right')
mn('<C-S-j>', '<cmd>Treewalker SwapDown<cr>', 'Treewalker Swap Down')
mn('<C-S-k>', '<cmd>Treewalker SwapUp<cr>', 'Treewalker Swap Up')

mn('<C-M-h>', '<C-w><C-h>', 'Move focus to the left window')
mn('<C-M-l>', '<C-w><C-l>', 'Move focus to the right window')
mn('<C-M-j>', '<C-w><C-j>', 'Move focus to the lower window')
mn('<C-M-k>', '<C-w><C-k>', 'Move focus to the upper window')

mn('<C-Right>', '<C-w>2>', 'Increase window width')
mn('<C-Left>', '<C-w>2<', 'Decrease window width')
mn('<C-Down>', '<C-w>2+', 'Increase window height')
mn('<C-Up>', '<C-w>2-', 'Decrease window height')

mn('n', 'nzzzv', 'Next search match')
mn('N', 'Nzzzv', 'Previous search match')
mn('-', '/', 'Search')

mn('H', '0', 'Go to start of line')
mv('H', '0', 'Go to start of line')
mn('L', '$', 'Go to end of line')
mv('L', '$', 'Go to end of line')

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
