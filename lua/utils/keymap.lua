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

local pending_groups = {}

function M.l_group(key, desc)
  pending_groups[#pending_groups + 1] = { mode = { "n", "v" }, { "<leader>" .. key, group = desc } }
end

function M.group(key, desc)
  pending_groups[#pending_groups + 1] = { mode = { "n", "v" }, { key, group = desc } }
end

function M._flush_groups()
  if #pending_groups > 0 then
    local wk = require("which-key")
    for _, group in ipairs(pending_groups) do
      wk.add(group)
    end
    pending_groups = {}
  end
end

return M
