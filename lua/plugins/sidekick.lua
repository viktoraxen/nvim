return {
  "folke/sidekick.nvim",
  dependencies = { "zbirenbaum/copilot.lua" },
  opts = {
    -- add any options here
    cli = {
      mux = {
        enabled = true,
      },
      win = {
        layout = "float",
        float = { width = 0.85, height = 0.85 },
      },
    },
    nes = {
      enabled = false,
    },
  },
  -- config = function(_, opts)
  --     require("sidekick").setup(opts)
  --
  --     vim.api.nvim_create_autocmd("InsertEnter", {
  --         callback = function()
  --             require("sidekick.nes").disable()
  --         end,
  --     })
  --
  --     vim.api.nvim_create_autocmd("InsertLeave", {
  --         callback = function()
  --             require("sidekick.nes").enable()
  --         end,
  --     })
  -- end,
  keys = {
    {
      "<Tab>",
      function()
        -- if there is a next edit, jump to it, otherwise apply it if any
        if not require("sidekick").nes_jump_or_apply() then
          return "<Tab>"
        end
      end,
      expr = true,
      desc = "Goto/Apply Next Edit Suggestion",
    },
    {
      "<leader>aa",
      function()
        require("sidekick.cli").toggle()
      end,
      desc = "Sidekick Toggle CLI",
    },
    {
      "<leader>as",
      function()
        require("sidekick.cli").select()
      end,
      -- Or to select only installed tools:
      -- require("sidekick.cli").select({ filter = { installed = true } })
      desc = "Select CLI",
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
    {
      "<leader>ap",
      function()
        require("sidekick.cli").prompt()
      end,
      mode = { "n", "x" },
      desc = "Sidekick Select Prompt",
    },
    -- Example of a keybinding to open Claude directly
    {
      "<leader>ac",
      function()
        require("sidekick.cli").toggle({ name = "claude", focus = true })
      end,
      desc = "Sidekick Toggle Claude",
    },
  },
}
