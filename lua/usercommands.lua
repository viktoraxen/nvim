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

vim.api.nvim_create_user_command("Goto", function(args)
  local fargs = args.fargs
  local direction = fargs[1]
  local last = fargs[#fargs]
  local has_query = last:sub(1, 1) ~= "@"
  local query = has_query and last or "textobjects"
  local object_idx = has_query and #fargs - 1 or #fargs
  local object = fargs[object_idx]
  local target = object_idx > 2 and fargs[2] or nil
  local move = require("nvim-treesitter-textobjects.move")

  local command = "goto_" .. direction .. (target and ("_" .. target) or "")
  move[command](object, query)
end, { desc = "Move to textobject", nargs = "+" })

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

vim.api.nvim_create_user_command("Select", function(args)
  local object = args.fargs[1]
  local query = args.fargs[2] or "textobjects"
  local select = require("nvim-treesitter-textobjects.select")

  select.select_textobject(object, query)
end, { desc = "Select textobject", nargs = "+" })

vim.api.nvim_create_user_command("Swap", function(args)
  local direction = args.fargs[1]
  local object = args.fargs[2] or "textobjects"
  local swap = require("nvim-treesitter-textobjects.swap")

  local command = "swap_" .. direction
  swap[command](object)
end, { desc = "Select textobject", nargs = "+" })
