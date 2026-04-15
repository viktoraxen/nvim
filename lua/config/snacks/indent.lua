return {
  filter = function(buf)
    return vim.bo[buf].filetype ~= "markdown"
  end,
  indent = { only_scope = true, only_current = true },
  scope = { only_current = true },
}
