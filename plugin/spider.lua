vim.pack.add({ "https://github.com/chrisgrieser/nvim-spider" })

require("which-key").add({
  mode = { "n", "v" },

  { "e", "<cmd>lua require('spider').motion('e')<cr>", desc = "End of word" },
  { "e", "<cmd>lua require('spider').motion('e')<cr>", desc = "End of word" },
  { "e", "<cmd>lua require('spider').motion('e')<cr>", desc = "End of word" },

  { "w", "<cmd>lua require('spider').motion('w')<cr>", desc = "Start of next word" },
  { "w", "<cmd>lua require('spider').motion('w')<cr>", desc = "Start of next word" },
  { "w", "<cmd>lua require('spider').motion('w')<cr>", desc = "Start of next word" },

  { "b", "<cmd>lua require('spider').motion('b')<cr>", desc = "Start of previous word" },
  { "b", "<cmd>lua require('spider').motion('b')<cr>", desc = "Start of previous word" },
  { "b", "<cmd>lua require('spider').motion('b')<cr>", desc = "Start of previous word" },

  { "E", "e", desc = "End of word" },
  { "E", "e", desc = "End of word" },
  { "W", "w", desc = "Start of next word" },
  { "W", "w", desc = "Start of next word" },
  { "B", "b", desc = "Start of previous word" },
  { "B", "b", desc = "Start of previous word" },
})
