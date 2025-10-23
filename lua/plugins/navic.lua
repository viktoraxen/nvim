return {
    'SmiteshP/nvim-navic',
    event = "VeryLazy",
    opts = {
        lsp = {
            auto_attach = true,
        },
        highlight = true,
    },
    config = function(_, opts)
        local navic = require('nvim-navic')

        navic.setup(opts)

        vim.api.nvim_set_hl(0, "NavicIconsFile", { link = "@text.reference" })
        vim.api.nvim_set_hl(0, "NavicIconsModule", { link = "@lsp.type.namespace" })
        vim.api.nvim_set_hl(0, "NavicIconsNamespace", { link = "@lsp.type.namespace" })
        vim.api.nvim_set_hl(0, "NavicIconsPackage", { link = "@lsp.type.namespace" })
        vim.api.nvim_set_hl(0, "NavicIconsClass", { link = "@lsp.type.class" })
        vim.api.nvim_set_hl(0, "NavicIconsMethod", { link = "@lsp.type.method" })
        vim.api.nvim_set_hl(0, "NavicIconsProperty", { link = "@lsp.type.property" })
        vim.api.nvim_set_hl(0, "NavicIconsField", { link = "@lsp.type.parameter" })
        vim.api.nvim_set_hl(0, "NavicIconsConstructor", { link = "@lsp.type.function" })
        vim.api.nvim_set_hl(0, "NavicIconsEnum", { link = "@lsp.type.enum" })
        vim.api.nvim_set_hl(0, "NavicIconsInterface", { link = "@lsp.type.interface" })
        vim.api.nvim_set_hl(0, "NavicIconsFunction", { link = "@lsp.type.function" })
        vim.api.nvim_set_hl(0, "NavicIconsVariable", { link = "@lsp.type.variable" })
        vim.api.nvim_set_hl(0, "NavicIconsConstant", { link = "@lsp.type.constant" })
        vim.api.nvim_set_hl(0, "NavicIconsString", { link = "@lsp.type.string" })
        vim.api.nvim_set_hl(0, "NavicIconsNumber", { link = "@lsp.type.number" })
        vim.api.nvim_set_hl(0, "NavicIconsBoolean", { link = "@lsp.type.boolean" })
        vim.api.nvim_set_hl(0, "NavicIconsArray", { link = "@lsp.type.keyword" })
        vim.api.nvim_set_hl(0, "NavicIconsObject", { link = "@lsp.type.class" })
        vim.api.nvim_set_hl(0, "NavicIconsKey", { link = "@lsp.type.key" })
        vim.api.nvim_set_hl(0, "NavicIconsNull", { link = "@lsp.type.number" })
        vim.api.nvim_set_hl(0, "NavicIconsEnumMember", { link = "@lsp.type.enumMember" })
        vim.api.nvim_set_hl(0, "NavicIconsStruct", { link = "@lsp.type.struct" })
        vim.api.nvim_set_hl(0, "NavicIconsEvent", { link = "@lsp.type.event" })
        vim.api.nvim_set_hl(0, "NavicIconsOperator", { link = "@lsp.type.operator" })
        vim.api.nvim_set_hl(0, "NavicIconsTypeParameter", { link = "@lsp.type.typeParameter" })
        vim.api.nvim_set_hl(0, "NavicText", { link = "@text.reference" })
        vim.api.nvim_set_hl(0, "NavicSeparator", { link = "@text.reference" })

        local navic_group = vim.api.nvim_create_augroup("NavicOnWinbar", { clear = true })

        local exclude_ft = {
            "neo-tree",
            "alpha",
            "snacks_terminal",
        }

        local filebar = function()
            if vim.tbl_contains(exclude_ft, vim.bo.ft) then
                return ""
            end

            local filename = vim.fn.expand("%:t")
            local filepath = vim.fn.fnamemodify(vim.fn.expand "%", ":~:.:h"):gsub("[.]/?", "")

            if filename == '' then
                vim.opt_local.winbar = ""
                return
            end

            local filename_hl = "lualine_b_normal"
            local filepath_hl = "lualine_c_normal"

            local filename_string = "%#" .. filename_hl .. "#󰧮 " .. filename .. "%##"
            local filepath_string = "%#" .. filepath_hl .. "# " .. filepath .. "%##"

            if filepath == '' then
                filepath_string = ''
            end

            return filename_string .. " " .. filepath_string
        end

        vim.api.nvim_create_autocmd({ "LspAttach", "CursorHold" }, {
            group = navic_group,
            pattern = "*",
            callback = function()
                if navic.is_available() then
                    local location = navic.get_location()

                    if location == "" then
                        location = " "
                    end

                    vim.opt_local.winbar = location
                else
                    vim.opt_local.winbar = filebar()
                end
            end
        })

        vim.api.nvim_create_autocmd('WinLeave', {
            desc = 'Set winbar to filename when leaving window.',
            pattern = '*',
            callback = function()
                vim.opt_local.winbar = filebar()
            end,
        })
    end
}
