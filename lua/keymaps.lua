local map = require("utils.keymap")

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
local function clear_hl_and_notifications()
  vim.cmd("nohlsearch")
  Snacks.notifier.hide()
end

map.ln("R", ":so<cr>", "Reload config")

map.n("<Esc>", clear_hl_and_notifications, "Clear search highlight and notifications")

-- Groups
map.l_group("a", "Sidekick")
map.l_group("c", "Copilot")
map.l_group("d", "Debug")
map.l_group("g", "Git")
map.l_group("gd", "Diff")
map.l_group("l", "Language Server")
map.l_group("p", "Peek")
map.l_group("s", "Search")
map.l_group("t", "Tab")

-- Visual editing
map.v("=", "=gv", "Auto-indent selection")
map.v(">", ">gv", "Indent selection")
map.v("<", "<gv", "De-indent selection")

-- Basic
map.n("<c-q>", "<cmd>q<cr>", "Close buffer")
map.ln("q", "<cmd>q<cr>", "Close buffer")
map.ln("Q", "<cmd>qa<cr>", "Close Neovim")
map.ln("w", "<cmd>w<cr>", "Save buffer")

local function prev_diag()
  vim.diagnostic.jump({ count = -1 })
end

local function next_diag()
  vim.diagnostic.jump({ count = 1 })
end

map.n("gh", vim.diagnostic.open_float, "Show line diagnostics")
map.n("gj", next_diag, "Next diagnostic")
map.n("gk", prev_diag, "Previous diagnostic")

-- Shorten description for this keybinding
map.n("gX", "gX", "Open file")

-- LSP keymaps
map.n("K", vim.lsp.buf.hover, "Hover")

map.group("g", "Go to")
map.group("gr", "LSP Buffer")

map.n("gra", vim.lsp.buf.code_action, "Code action")
map.n("grf", vim.lsp.buf.format, "Format buffer")
map.n("grn", vim.lsp.buf.rename, "Rename symbol")

-- Copy
map.n("yA", "ggyG", "Copy all")
map.n("vA", "ggVG", "Select all")
map.n("dA", "ggdG", "Delete all")
map.n("cA", "ggcG", "Change all")

-- Replace
map.ln("r", ":%s/<c-r><c-w>//g<left><left>", "Replace word under cursor")

-- Insert mode
map.i("jj", "<Esc>", "Exit insert mode")
map.i("<C-Del>", "<C-o>dw", "Remove word after")
map.i("", "<esc>jdb", "Remove word before")

-- Pasting
map.v("p", '"_dP', "Paste without yanking")

map.t("<C-x>", "<C-\\><C-n>", "Exit terminal mode")

-- Window
map.n("<C-h>", "<C-w><C-h>", "Move focus to the left window")
map.n("<C-l>", "<C-w><C-l>", "Move focus to the right window")
map.n("<C-j>", "<C-w><C-j>", "Move focus to the lower window")
map.n("<C-k>", "<C-w><C-k>", "Move focus to the upper window")

map.t("<C-h>", "<C-w><C-h>", "Move focus to the left window")
map.t("<C-l>", "<C-w><C-l>", "Move focus to the right window")
map.t("<C-j>", "<C-w><C-j>", "Move focus to the lower window")
map.t("<C-k>", "<C-w><C-k>", "Move focus to the upper window")

map.n("<C-Right>", "<C-w>2>", "Increase window width")
map.n("<C-Left>", "<C-w>2<", "Decrease window width")
map.n("<C-Down>", "<C-w>2+", "Increase window height")
map.n("<C-Up>", "<C-w>2-", "Decrease window height")

map.n("n", "nzzzv", "Next search match")
map.n("N", "Nzzzv", "Previous search match")
map.n("-", "/", "Search")

map.n("H", "0", "Go to start of line")
map.v("H", "0", "Go to start of line")
map.n("L", "$", "Go to end of line")
map.v("L", "$", "Go to end of line")

map.l_group("v", "Window")

map.ln("vv", "<C-w>v", "Split window vertically")
map.ln("vs", "<C-w>s", "Split window horizontally")
map.ln("ve", "<C-w>=", "Equalize window size")
map.ln("vt", "<C-w>v:term<cr>", "Vertical terminal")

local move_window = function(direction)
  vim.cmd("wincmd " .. direction)
  vim.wo.winhl = ""
  vim.wo.winblend = 0
end

map.ln("vl", function()
  move_window("L")
end, "Move window to right")
map.ln("vh", function()
  move_window("H")
end, "Move window to left")
map.ln("vj", function()
  move_window("J")
end, "Move window to bottom")
map.ln("vk", function()
  move_window("K")
end, "Move window to top")

-- Line numbers
map.l_group("n", "Line Numbers")

map.ln("nn", "<cmd>set invnumber<cr>", "Toggle line numbers")
map.ln("nr", "<cmd>set invrelativenumber<cr>", "Toggle relative line numbers")

local function rename_tab()
  Snacks.input({
    prompt = "Tab name",
    win = { relative = "editor", row = math.floor(vim.o.lines / 2), col = math.floor((vim.o.columns - 40) / 2) },
  }, function(name)
    if name then
      require("tabby.feature.tab_name").set(0, name)
    end
  end)
end

local close_tab = function()
  if vim.fn.tabpagenr("$") > 1 then
    vim.cmd.tabclose()
  else
    vim.cmd.qa()
  end
end

map.ln("tt", "<cmd>tabnew<cr>", "Create")
map.ln("tn", rename_tab, "Rename tab")
map.ln("tq", close_tab, "Close tab")
