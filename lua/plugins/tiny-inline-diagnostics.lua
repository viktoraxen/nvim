return {
    {
        "rachartier/tiny-inline-diagnostic.nvim",
        event = "VeryLazy",
        priority = 1000,
        opts = {
            preset = "simple",
            options = {
                add_messages = { display_count = true },
                -- show_source = { enabled = true, if_many = true },
                multilines = { enabled = true },
                show_all_diags_on_cursorline = true,
                enable_on_insert = true,
                overflow = { padding = -8 },
            },
        },
    },
}
