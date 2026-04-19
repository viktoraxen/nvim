vim.api.nvim_create_user_command("Terminal", function(args)
  if #args.fargs == 0 then
    Snacks.terminal.toggle()
  else
    Snacks.terminal.toggle("zsh", { env = { id = args.args } })
  end
end, { desc = "Terminal", nargs = "?" })

require("which-key").add({
  mode = { "n", "t" },

  { "<M-1>", "<cmd>Terminal 1<cr>", desc = "Terminal 1" },
  { "<M-2>", "<cmd>Terminal 2<cr>", desc = "Terminal 2" },
  { "<M-3>", "<cmd>Terminal 3<cr>", desc = "Terminal 3" },
  { "<M-4>", "<cmd>Terminal 4<cr>", desc = "Terminal 4" },
  { "<M-5>", "<cmd>Terminal 5<cr>", desc = "Terminal 5" },
  { "<M-6>", "<cmd>Terminal 6<cr>", desc = "Terminal 6" },
  { "<M-7>", "<cmd>Terminal 7<cr>", desc = "Terminal 7" },
  { "<M-8>", "<cmd>Terminal 8<cr>", desc = "Terminal 8" },
  { "<M-9>", "<cmd>Terminal 9<cr>", desc = "Terminal 9" },
})

return {
  win = {
    style = "float",
    backdrop = false,
    border = "solid",
    width = 0.85,
    height = 0.85,
  },
}
