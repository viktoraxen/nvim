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
    config = function()
        require("neogit").setup({
            graph_style = "unicode",
            kind = "tab",
            signs = {
                hunk = { "", "" },
                item = { "", "" },
                section = { "", "" },
            },
        })
    end
}
