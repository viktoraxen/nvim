return {
    "sindrets/diffview.nvim",
    keys = {
        { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "DiffView" }
    },
    config = function()
        require("diffview").setup({
            file_panel = {
                win_config = {
                    position = "right",
                },
            },
        })
    end
}
