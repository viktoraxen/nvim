return {
    'SmiteshP/nvim-navic',
    event = "VeryLazy",
    config = function()
        local navic = require('nvim-navic')

        navic.setup({
            lsp = {
                auto_attach = true,
            },
            highlight = true,
        })

        vim.api.nvim_set_hl(0, "NavicIconsFile", { link = "lualine_c_normal" })
        vim.api.nvim_set_hl(0, "NavicIconsModule", { link = "lualine_c_normal" })
        vim.api.nvim_set_hl(0, "NavicIconsNamespace", { link = "lualine_c_normal" })
        vim.api.nvim_set_hl(0, "NavicIconsPackage", { link = "lualine_c_normal" })
        vim.api.nvim_set_hl(0, "NavicIconsClass", { link = "lualine_c_normal" })
        vim.api.nvim_set_hl(0, "NavicIconsMethod", { link = "lualine_c_normal" })
        vim.api.nvim_set_hl(0, "NavicIconsProperty", { link = "lualine_c_normal" })
        vim.api.nvim_set_hl(0, "NavicIconsField", { link = "lualine_c_normal" })
        vim.api.nvim_set_hl(0, "NavicIconsConstructor", { link = "lualine_c_normal" })
        vim.api.nvim_set_hl(0, "NavicIconsEnum", { link = "lualine_c_normal" })
        vim.api.nvim_set_hl(0, "NavicIconsInterface", { link = "lualine_c_normal" })
        vim.api.nvim_set_hl(0, "NavicIconsFunction", { link = "lualine_c_normal" })
        vim.api.nvim_set_hl(0, "NavicIconsVariable", { link = "lualine_c_normal" })
        vim.api.nvim_set_hl(0, "NavicIconsConstant", { link = "lualine_c_normal" })
        vim.api.nvim_set_hl(0, "NavicIconsString", { link = "lualine_c_normal" })
        vim.api.nvim_set_hl(0, "NavicIconsNumber", { link = "lualine_c_normal" })
        vim.api.nvim_set_hl(0, "NavicIconsBoolean", { link = "lualine_c_normal" })
        vim.api.nvim_set_hl(0, "NavicIconsArray", { link = "lualine_c_normal" })
        vim.api.nvim_set_hl(0, "NavicIconsObject", { link = "lualine_c_normal" })
        vim.api.nvim_set_hl(0, "NavicIconsKey", { link = "lualine_c_normal" })
        vim.api.nvim_set_hl(0, "NavicIconsNull", { link = "lualine_c_normal" })
        vim.api.nvim_set_hl(0, "NavicIconsEnumMember", { link = "lualine_c_normal" })
        vim.api.nvim_set_hl(0, "NavicIconsStruct", { link = "lualine_c_normal" })
        vim.api.nvim_set_hl(0, "NavicIconsEvent", { link = "lualine_c_normal" })
        vim.api.nvim_set_hl(0, "NavicIconsOperator", { link = "lualine_c_normal" })
        vim.api.nvim_set_hl(0, "NavicIconsTypeParameter", { link = "lualine_c_normal" })
        vim.api.nvim_set_hl(0, "NavicText", { link = "lualine_c_normal" })
        vim.api.nvim_set_hl(0, "NavicSeparator", { link = "lualine_c_normal" })

        local navic_group = vim.api.nvim_create_augroup("NavicOnWinbar", { clear = true })

        vim.api.nvim_create_autocmd({ "LspAttach", "CursorHold" }, {
            group = navic_group,
            pattern = "*",
            callback = function()
                if navic.is_available() then
                    vim.opt_local.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
                else
                    vim.opt_local.winbar = ""
                end
            end
        })
    end
}
