vim.api.nvim_create_autocmd({
  'BufNewFile',
  'BufRead',
}, {
  pattern = '*.cmd',
  callback = function()
    local buf = vim.api.nvim_get_current_buf()
    vim.api.nvim_buf_set_option(buf, 'filetype', 'cmdl')
  end,
})

local parser_config = require('nvim-treesitter.parsers').get_parser_configs()
parser_config.cmdl = {
  install_info = {
    -- Change this url to your grammar
    -- url = "~/dev/tree-sitter-cmdl",
    url = 'https://github.com/lyktstolpe/tree-sitter-cmdl',
    -- If you use an external scanner it needs to be included here
    files = { 'src/parser.c' },
    branch = 'main', -- default branch in case of git repo if different from master
    generate_reqires_npm = false,
    requires_generate_from_grammar = false,
  },
  -- The filetype you want it registered as
  filetype = 'cmdl',
}
