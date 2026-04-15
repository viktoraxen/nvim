vim.api.nvim_create_user_command("CodeAction", function()
  require("tiny-code-action").code_action()
end, { desc = "Code action" })

vim.api.nvim_create_user_command("Config", function()
  vim.cmd.cd(vim.fn.stdpath("config"))
  require("persistence").load()
end, { desc = "Open Neovim configuration" })

vim.api.nvim_create_user_command("Dashboard", function()
  Snacks.dashboard()
end, { desc = "Open dashboard" })

vim.api.nvim_create_user_command("Packupdate", function()
  vim.pack.update()
end, { desc = "Update plugins" })

vim.api.nvim_create_user_command("Picker", function(args)
  local config = {}

  if #args.fargs > 1 then
    config = require("config.snacks.configs")[args.fargs[2]]
  end

  Snacks.picker.pick(args.fargs[1], config)
end, { desc = "Picker", nargs = "+" })

vim.api.nvim_create_user_command("Restore", function()
  require("persistence").load({ last = true })
end, { desc = "Restore last session" })
