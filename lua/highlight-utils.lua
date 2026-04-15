local M = {}

function M.blend(c1, c2, alpha)
  if not c1 or not c2 then
    return nil
  end
  local r1, g1, b1 = bit.rshift(c1, 16), bit.band(bit.rshift(c1, 8), 0xFF), bit.band(c1, 0xFF)
  local r2, g2, b2 = bit.rshift(c2, 16), bit.band(bit.rshift(c2, 8), 0xFF), bit.band(c2, 0xFF)
  return string.format(
    "#%02x%02x%02x",
    math.floor(r1 * alpha + r2 * (1 - alpha)),
    math.floor(g1 * alpha + g2 * (1 - alpha)),
    math.floor(b1 * alpha + b2 * (1 - alpha))
  )
end

function M.get(group, field)
  return vim.api.nvim_get_hl(0, { name = group })[field]
end

function M.lighten(group, alpha)
  return M.blend(M.get(group, "bg"), 0xffffff, alpha)
end

function M.darken(group, alpha)
  return M.blend(M.get(group, "bg"), 0x000000, alpha)
end

function M.set(groups)
  for name, opts in pairs(groups) do
    vim.api.nvim_set_hl(0, name, opts)
  end
end

function M.link(groups)
  for name, target in pairs(groups) do
    vim.api.nvim_set_hl(0, name, { link = target })
  end
end

return M
