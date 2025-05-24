return {
    "williamboman/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonUninstall" },
    opts = {
        ensure_installed = {
            "stylua",
            "clangd"
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
