return {
    "sindrets/diffview.nvim",
    keys = {
        { "<leader>gd", "<cmd>DiffViewOpen<cr>", desc = "DiffView" }
    },
    opts = {
        file_panel = {
            win_config = {
                position = "right",
            },
        },
    }
}
