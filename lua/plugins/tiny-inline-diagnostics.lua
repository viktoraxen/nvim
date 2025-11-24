return {
  {
    'rachartier/tiny-inline-diagnostic.nvim',
    event = 'VeryLazy',
    priority = 1000,
    opts = {
      preset = 'classic',
      transparent_bg = true,
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
