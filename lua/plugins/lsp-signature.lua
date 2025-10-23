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

        transparency = 5,
        toggle_key = "<c-c>",
        select_signature_key = "<m-j>",
    },
    config = function(_, opts)
        require("custom-highlights-nvim").add({
            customizations = {
                catppuccin = { LspSignatureActiveParameter = { bg = "surface2" } }
            }
        })

        require('lsp_signature').setup(opts)
    end
}
