return {
    'akinsho/toggleterm.nvim',
    config = function()
        require('toggleterm').setup {
            size = function()
                return math.floor(vim.o.columns * 0.5)
            end,
            hide_numbers = true,
            shade_filetypes = {},
            shade_terminals = true,
            start_in_insert = true,
            insert_mappings = true,
            persist_size = true,
            direction = 'vertical',
            close_on_exit = false,
            shell = vim.o.shell,
            float_opts = {
                border = 'double',
                winblend = 15,
                width = function()
                    return math.floor(vim.o.columns * 0.9)
                end,
                height = function()
                    return math.floor(vim.o.lines * 0.8)
                end,
            },
        }
    end,
}
