vim.pack.add({ "https://github.com/folke/which-key.nvim" })

local which_key = require("which-key")

which_key.setup({
  delay = 1000,
  preset = "helix",
  sort = { "local", "order", "alphanum" },
  win = {
    no_overlap = false,
    border = "solid",
    title = false,
    height = { min = 20, max = 0.8 },
    width = { min = 35, max = 0.35 },
    wo = { winblend = 0 },
  },
  icons = {
    rules = false,
    separator = ":",
    keys = {
      Up = " ",
      Down = " ",
      Left = " ",
      Right = " ",
      C = "C-",
      M = "M-",
      S = "S-",
      BS = "󰭜 ",
    },
  },
})

local utils = require("utils")

which_key.add({
  {
    mode = { "i" },

    { "jj", "<esc>", desc = "Exit insert mode" },
  },
  {
    mode = { "t" },

    { "<C-x>", "<C-\\><C-n>", desc = "Exit terminal mode" },
  },
  {
    mode = { "v" },

    { "p", '"_dP', desc = "Paste without yanking" },
  },
  {
    mode = { "n" },

    { "<esc>", "<cmd>nohlsearch<cr>", desc = "Clear search" },
  },
  {
    mode = { "n", "v" },

    { "-", "/", desc = "Search forward" },
    { "*", utils.search_word_under_cursor, desc = "Search word under cursor" },

    -- Use system clipboard for yank/delete/change/put
    { "y", '"+y', desc = "Yank" },
    { "Y", '"+Y', desc = "Yank" },
    { "d", '"+d', desc = "Delete" },
    { "D", '"+D', desc = "Delete" },
    { "c", '"+c', desc = "Change" },
    { "C", '"+C', desc = "Change" },
    { "p", '"+p', desc = "Put" },
    { "P", '"+P', desc = "Put above" },

    { "H", "0", desc = "Start of line" },
    { "L", "$", desc = "End of line" },

    { "<leader>q", "<cmd>q<cr>", desc = "Close window" },
    { "<leader>Q", "<cmd>qa<cr>", desc = "Close all windows" },
    { "<leader>w", "<cmd>w<cr>", desc = "Write buffer" },
    { "<leader>r", "<cmd>%s/<c-r><c-w>//g<left><left>", desc = "Replace word under cursor" },

    { "<c-h>", "<c-w>h", desc = "Switch window left" },
    { "<c-j>", "<c-w>j", desc = "Switch window down" },
    { "<c-k>", "<c-w>k", desc = "Switch window up" },
    { "<c-l>", "<c-w>l", desc = "Switch window right" },

    { "<c-right>", "<c-w>2>", desc = "Increase window width" },
    { "<c-left>", "<c-w>2<", desc = "Decrease window width" },
    { "<c-down>", "<c-w>2+", desc = "Increase window height" },
    { "<c-up>", "<c-w>2-", desc = "Decrease window height" },

    { "<leader>v", group = "Window" },

    { "<leader>vh", "<c-w>H", desc = "Move window to far left" },
    { "<leader>vj", "<c-w>J", desc = "Move window to far bottom" },
    { "<leader>vk", "<c-w>K", desc = "Move window to far top" },
    { "<leader>vl", "<c-w>L", desc = "Move window to far right" },
    { "<leader>vv", "<c-w>v", desc = "Split window vertically" },
    { "<leader>vs", "<c-w>s", desc = "Split window horizontally" },
    { "<leader>ve", "<c-w>=", desc = "Equalize window size" },

    { "<leader>n", group = "Line numbers" },

    { "<leader>nn", "<cmd>set invnumber<cr>", desc = "Toggle line numbers" },
    { "<leader>nr", "<cmd>set invrnu<cr>", desc = "Toggle relative line numbers" },

    { "<leader>t", group = "Tab" },

    { "<leader>tt", "<cmd>tabnew<cr>", desc = "New tab" },
    { "<leader>tq", "<cmd>tabclose<cr>", desc = "Close tab" },

    { "<leader>R", utils.restart_neovim, desc = "Restart Neovim" },
  },
})
