return {
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "LspAttach",
    opts = {
      preset = "classic",
      transparent_bg = true,
      blend = { factor = 0 },
      options = {
        add_messages = { display_count = true },
        -- show_source = { enabled = true, if_many = true },
        multilines = { enabled = true },
        show_all_diags_on_cursorline = true,
        enable_on_insert = false,
        overflow = { padding = -8 },
        use_icons_from_diagnostic = true,
        override_open_float = true,
      },
    },
  },
}
