vim.pack.add({
  {
    src = "https://github.com/nvim-treesitter/nvim-treesitter",
    version = "main",
  },
})

vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == "nvim-treesitter" and kind == "update" then
      if not ev.data.active then
        vim.cmd.packadd("nvim-treesitter")
      end
      vim.cmd("TSUpdate")
    end
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  desc = "Start treesitter highlighting when a parser is available",
  callback = function(ev)
    pcall(vim.treesitter.start, ev.buf)
  end,
})

vim.schedule(function()
  vim.pack.add({
    {
      src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects",
      version = "main",
    },
  })

  vim.g.no_plugin_maps = true

  require("nvim-treesitter-textobjects").setup({
    select = {
      selection_modes = {
        ["@parameter.outer"] = "v",
        ["@function.outer"] = "V",
        ["@class.outer"] = "V",
        ["@loop.outer"] = "V",
        ["@conditional.outer"] = "V",
      },
    },
    lookahead = true,
    include_surrounding_whitespace = true,
  })

  require("which-key").add({
    {
      mode = { "n" },

      { "gs", group = "Swap" },

      { "gsn", "<cmd>Swap next @parameter.inner<cr>", desc = "Parameter next" },
      { "gsp", "<cmd>Swap previous @parameter.inner<cr>", desc = "Parameter previous" },

      { "gsf", group = "Function" },

      { "gsfn", "<cmd>Swap next @function.outer<cr>", desc = "Down" },
      { "gsfp", "<cmd>Swap next @function.outer<cr>", desc = "Up" },
    },
    {
      mode = { "x", "o" },

      { "af", "<cmd>Select @function.outer<cr>", desc = "Function" },
      { "if", "<cmd>Select @function.inner<cr>", desc = "Function" },

      { "ac", "<cmd>Select @class.outer<cr>", desc = "Class" },
      { "ic", "<cmd>Select @class.inner<cr>", desc = "Class" },

      { "al", "<cmd>Select @loop.outer<cr>", desc = "Loop" },
      { "il", "<cmd>Select @loop.inner<cr>", desc = "Loop" },

      { "ai", "<cmd>Select @conditional.outer<cr>", desc = "Conditional" },
      { "ii", "<cmd>Select @conditional.inner<cr>", desc = "Conditional" },
    },
    {
      mode = { "n", "x", "o" },

      { "]f", "<cmd>Goto next start @function.outer<cr>", desc = "Function start" },
      { "[f", "<cmd>Goto previous start @function.outer<cr>", desc = "Function start" },
      { "]F", "<cmd>Goto next end @function.outer<cr>", desc = "Function end" },
      { "[F", "<cmd>Goto previous end @function.outer<cr>", desc = "Function end" },

      { "]c", "<cmd>Goto next start @class.outer<cr>", desc = "Class start" },
      { "[c", "<cmd>Goto previous start @class.outer<cr>", desc = "Class start" },
      { "]C", "<cmd>Goto next end @class.outer<cr>", desc = "Class end" },
      { "[C", "<cmd>Goto previous end @class.outer<cr>", desc = "Class end" },

      { "]l", "<cmd>Goto next start @loop.outer<cr>", desc = "Loop start" },
      { "[l", "<cmd>Goto previous start @loop.outer<cr>", desc = "Loop start" },
      { "]L", "<cmd>Goto next end @loop.outer<cr>", desc = "Loop end" },
      { "[L", "<cmd>Goto previous end @loop.outer<cr>", desc = "Loop end" },

      { "]i", "<cmd>Goto next start @conditional.outer<cr>", desc = "Conditional start" },
      { "[i", "<cmd>Goto previous start @conditional.outer<cr>", desc = "Conditional start" },
      { "]I", "<cmd>Goto next end @conditional.outer<cr>", desc = "Conditional end" },
      { "[I", "<cmd>Goto previous end @conditional.outer<cr>", desc = "Conditional end" },

      { "]s", "<cmd>Goto next start @scope.outer<cr>", desc = "Local scope start" },
      { "[s", "<cmd>Goto previous start @scope.outer<cr>", desc = "Local scope start" },
      { "]S", "<cmd>Goto next end @scope.outer<cr>", desc = "Local scope end" },
      { "[S", "<cmd>Goto previous end @scope.outer<cr>", desc = "Local scope end" },
    },
  })
end)
