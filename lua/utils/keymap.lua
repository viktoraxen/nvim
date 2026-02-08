local M = {}

local function map(mode, key, action, desc)
  vim.keymap.set(mode, key, action, { desc = desc })
end

function M.o(key, action, desc)
  map("o", key, action, desc)
end

function M.n(key, action, desc)
  map("n", key, action, desc)
end

function M.v(key, action, desc)
  map("v", key, action, desc)
end

function M.t(key, action, desc)
  map("t", key, action, desc)
end

function M.i(key, action, desc)
  map("i", key, action, desc)
end

function M.ln(key, action, desc)
  M.n("<leader>" .. key, action, desc)
end

function M.l_group(key, desc)
  require("which-key").add({ mode = { "n", "v" }, { "<leader>" .. key, group = desc } })
end

function M.group(key, desc)
  require("which-key").add({ mode = { "n", "v" }, { key, group = desc } })
end

return M
