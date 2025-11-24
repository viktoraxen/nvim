local M = {}

local map = function(mode, key, action, desc)
  vim.keymap.set(mode, key, action, { desc = desc })
end

M.o = function(key, action, desc)
  map('o', key, action, desc)
end

M.n = function(key, action, desc)
  map('n', key, action, desc)
end

M.v = function(key, action, desc)
  map('v', key, action, desc)
end

M.t = function(key, action, desc)
  map('t', key, action, desc)
end

M.i = function(key, action, desc)
  map('i', key, action, desc)
end

M.ln = function(key, action, desc)
  M.n('<leader>' .. key, action, desc)
end

M.l_group = function(key, desc)
  require('which-key').add { mode = { 'n', 'v' }, { '<leader>' .. key, group = desc } }
end

M.group = function(key, desc)
  require('which-key').add { mode = { 'n', 'v' }, { key, group = desc } }
end

return M
