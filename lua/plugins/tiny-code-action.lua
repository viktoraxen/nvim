return
{
    "rachartier/tiny-code-action.nvim",
    dependencies = {
        { "nvim-lua/plenary.nvim" },
    },
    event = "LspAttach",
    opts = {
        backend = "vim",
        picker = "buffer",
        signs = {
            quickfix = { "", { link = "DiagnosticWarning" } },
            others = { "", { link = "DiagnosticWarning" } },
            refactor = { "󰩫", { link = "DiagnosticInfo" } },
            ["refactor.move"] = { "󰪹", { link = "DiagnosticInfo" } },
            ["refactor.extract"] = { "", { link = "DiagnosticError" } },
            ["source.organizeImports"] = { "", { link = "DiagnosticWarning" } },
            ["source.fixAll"] = { "󰃢", { link = "DiagnosticError" } },
            ["source"] = { "", { link = "DiagnosticError" } },
            ["rename"] = { "󰑕", { link = "DiagnosticWarning" } },
            ["codeAction"] = { "", { link = "DiagnosticWarning" } },
        },
    }
}
