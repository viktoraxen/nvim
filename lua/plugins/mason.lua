return {
    "williamboman/mason.nvim",
    keys = {
        { "<leader>im", "<cmd>Mason<cr>", desc = "Mason" },
    },
    opts = {
        ensure_installed = {
            "stylua",
            "lua-language-server",
            "clangd",
            "pyright",
        },
        ui = {
            check_outdated_packages_on_open = true,
            border = 'rounded',
            backdrop = 100,

            width = 0.89,
            height = 0.88,
        }
    }
}
