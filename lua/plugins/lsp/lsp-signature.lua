return {
    "ray-x/lsp_signature.nvim",
    event = "InsertEnter",
    opts = {
        bind = true,
        doc_lines = 0,
        floating_window = true,
        hint_enable = false,
        hi_parameter = "String",
        toggle_key = "<C-s>",
        handler_opts = {
            border = "single",
        },
    },
}
