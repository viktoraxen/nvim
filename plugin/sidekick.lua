vim.schedule(function()
  vim.pack.add({ "https://github.com/folke/sidekick.nvim" })

  require("sidekick").setup({
    cli = {
      mux = { enabled = true },
      win = {
        layout = "left",
        float = { width = 0.85, height = 0.85 },
        split = { width = 0.4 },
      },
    },
    nes = { enabled = false },
    copilot = { status = { level = vim.log.levels.OFF } },
  })

  require("which-key").add({
    mode = { "n" },

    {
      "<leader>aa",
      function()
        require("sidekick.cli").toggle({ name = "claude", focus = true })
      end,
      desc = "Sidekick Toggle Claude",
    },
    {
      "<leader>aA",
      function()
        require("sidekick.cli").toggle()
      end,
      desc = "Sidekick Toggle CLI",
    },
    {
      "<leader>ad",
      function()
        require("sidekick.cli").close()
      end,
      desc = "Detach a CLI Session",
    },
    {
      "<leader>at",
      function()
        require("sidekick.cli").send({ msg = "{this}" })
      end,
      mode = { "x", "n" },
      desc = "Send This",
    },
    {
      "<leader>af",
      function()
        require("sidekick.cli").send({ msg = "{file}" })
      end,
      desc = "Send File",
    },
    {
      "<leader>av",
      function()
        require("sidekick.cli").send({ msg = "{selection}" })
      end,
      mode = { "x" },
      desc = "Send Visual Selection",
    },
  })
  require("highlight-utils").link({
    SidekickChat = "Normal",
  })
end)
