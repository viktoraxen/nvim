return {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
        {
            'L3MON4D3/LuaSnip',
            build = (function()
                if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
                    return
                end
                return 'make install_jsregexp'
            end)(),
            dependencies = {
                {
                    'rafamadriz/friendly-snippets',
                    config = function()
                        require('luasnip.loaders.from_vscode').lazy_load { exclude = { 'cpp' } }
                    end,
                },
            },
        },
        'saadparwaiz1/cmp_luasnip',

        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-path',
        'onsails/lspkind.nvim',
    },
    config = function()
        local cmp = require 'cmp'
        local ls = require 'luasnip'
        local lsloader = require 'luasnip.loaders.from_snipmate'

        lsloader.lazy_load { paths = '~/.config/nvim/snippets' }

        cmp.setup {
            enabled = function()
                if vim.bo.buftype == 'snacks_picker_input' then
                    return false
                end

                -- disable completion in comments
                local context = require 'cmp.config.context'

                -- keep command mode completion enabled when cursor is in a comment
                if vim.api.nvim_get_mode().mode == 'c' then
                    return true
                else
                    return not context.in_treesitter_capture 'comment' and not context.in_syntax_group 'Comment'
                end
            end,

            window = {
                completion = {
                    side_padding = 0,
                    border = 'none',
                    winblend = 5,
                    col_offset = 1,
                },
                documentation = {
                    border = 'solid',
                    max_height = 40,
                    winblend = 5,
                },
            },

            view = {
                docs = {
                    auto_open = false,
                },
            },

            snippet = {
                expand = function(args)
                    ls.lsp_expand(args.body)
                end,
            },

            completion = {
                completeopt = 'menu,menuone,noinsert',
            },

            mapping = cmp.mapping.preset.insert {
                ['<C-j>'] = cmp.mapping.select_next_item(),
                ['<C-k>'] = cmp.mapping.select_prev_item(),
                ['<C-o>'] = function()
                    if cmp.visible_docs() then
                        cmp.close_docs()
                    else
                        cmp.open_docs()
                    end
                end,

                -- Scroll the documentation window [b]ack / [f]orward
                ['<C-u>'] = cmp.mapping.scroll_docs(-1),
                ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                ['<C-d>'] = cmp.mapping.scroll_docs(1),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                ['<C-l>'] = cmp.mapping.confirm { select = true },
                ['<C-h>'] = cmp.mapping(function(fallback)
                    cmp.abort()
                    fallback()
                end, { 'i', 's' }),

                ['<C-Space>'] = cmp.mapping.complete {},

                ['<C-n>'] = cmp.mapping(function()
                    if ls.expand_or_locally_jumpable() then
                        ls.expand_or_jump()
                    end
                end, { 'i', 's' }),
                ['<C-p>'] = cmp.mapping(function()
                    if ls.locally_jumpable(-1) then
                        ls.jump(-1)
                    end
                end, { 'i', 's' }),
            },
            sources = {
                -- { name = 'copilot' },
                { name = 'nvim_lsp', priority = 1000, },
                { name = 'luasnip', },
                { name = 'path' },
            },
        }

        cmp.setup.filetype({ 'snacks_picker_input' }, {
            sources = {},
        })

        local lspkind = require 'lspkind'
        cmp.setup {
            formatting = {
                format = lspkind.cmp_format {
                    mode = 'symbol_text',
                    before = function(_, vim_item)
                        -- Trims the leading junk characters from the completion items
                        vim_item.abbr = vim_item.abbr:gsub('~$', '')
                        vim_item.abbr = vim_item.abbr:gsub('^•', '')
                        vim_item.abbr = vim_item.abbr:gsub('^%s+', ''):gsub('%s+$', '')

                        -- Make sure the completion items are all the same width
                        -- This is to make the window a consistent width
                        local max_width = 35
                        local display_width = vim.fn.strdisplaywidth(vim_item.abbr)

                        if display_width > max_width then
                            vim_item.abbr = vim.fn.strcharpart(vim_item.abbr, 0, max_width - 3) .. '...'
                        elseif display_width < max_width then
                            vim_item.abbr = vim_item.abbr .. string.rep(' ', max_width - display_width)
                        end

                        return vim_item
                    end,
                    menu = {
                        buffer = '[Buffer]',
                        nvim_lsp = '[LSP]',
                        luasnip = '[LuaSnip]',
                        nvim_lua = '[Lua]',
                        latex_symbols = '[Latex]',
                    },
                },
            },
        }
    end,
}
