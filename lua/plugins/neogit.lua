return {
    "NeogitOrg/neogit",
    keys = {
        { "<leader>gg", "<cmd>Neogit<cr>", desc = "Neogit" }
    },
    dependencies = {
        "nvim-lua/plenary.nvim",
        "sindrets/diffview.nvim",

        "folke/snacks.nvim",
    },
    opts = {
        graph_style = "unicode",
        kind = "tab",
        signs = {
            hunk = { "", "" },
            item = { "", "" },
            section = { "", "" },
        },
    },
}
