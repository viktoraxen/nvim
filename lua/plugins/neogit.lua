return {
    "NeogitOrg/neogit",
    keys = {
        { "<leader>gG", "<cmd>Neogit<cr>",                               desc = "Neogit" },
        { "<leader>gp", "<cmd>lua require('neogit').open({'pull'})<cr>", desc = "Pull" },
        { "<leader>gP", "<cmd>lua require('neogit').open({'push'})<cr>", desc = "Push" },
        { "<leader>gl", "<cmd>lua require('neogit').open({'log'})<cr>",  desc = "Log" },
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
