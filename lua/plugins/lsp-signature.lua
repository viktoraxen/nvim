return {
    "ray-x/lsp_signature.nvim",
    event = "InsertEnter",
    opts = {
        doc_lines = 0,
        floating_window = true,

        floating_window_above_cur_line = true,

        floating_window_off_x = -2,

        hint_enable = false,
        handler_opts = {
            border = "solid"
        },

        transparency = nil, -- disabled by default, allow floating win transparent value 1~100
        toggle_key = nil,   -- toggle signature on and off in insert mode,  e.g. toggle_key = '<M-x>'
    }
}
