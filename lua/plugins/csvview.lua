return {
  "hat0uma/csvview.nvim",
  ---@module "csvview"
  ---@type CsvView.Options
  opts = {
    parser = { comments = { "#", "//" } },
    sticky_header = { enabled = false },
    keymaps = {
      -- Text objects for selecting fields
      textobject_field_inner = { "if", mode = { "o", "x" } },
      textobject_field_outer = { "af", mode = { "o", "x" } },
      -- Excel-like navigation:
      -- Use <Tab> and <S-Tab> to move horizontally between fields.
      -- Use <Enter> and <S-Enter> to move vertically between rows and place the cursor at the end of the field.
      -- Note: In terminals, you may need to enable CSI-u mode to use <S-Tab> and <S-Enter>.
      jump_next_field_end = { "<Tab>", mode = { "n", "v" } },
      jump_prev_field_end = { "<S-Tab>", mode = { "n", "v" } },
    },
  },
  ft = "csv",
  cmd = { "CsvViewEnable", "CsvViewDisable", "CsvViewToggle" },
  config = function(_, opts)
    require("csvview").setup(opts)

    local hls = {}

    local csv_contrasts = { 1.0, 0.9, 0.8, 0.7, 0.6, 0.65, 0.7, 0.8, 0.9 }
    for i = 0, 8 do
      hls["CsvViewCol" .. i] = { fg = "Normal|contrast|" .. csv_contrasts[i + 1] }
    end

    require("highlights-nvim").add({
      customizations = {
        ["*"] = hls,
      },
    })

    require("csvview").enable()

    -- vim.api.nvim_create_autocmd("FileType", {
    --   desc = "Activate CsvView",
    --   pattern = "csv",
    --   callback = function(ev)
    --     vim.cmd("CsvViewEnable delimiter=, display_mode=border header_lnum=auto")
    --   end,
    -- })
  end,
}
