vim.g.lazygit_floating_window_winblend = 10 -- transparency of floating window
vim.g.lazygit_floating_window_scaling_factor = 0.85 -- scaling factor for floating window
-- vim.g.lazygit_floating_window_use_plenary = 1 -- use plenary.nvim to manage floating window if available

return {
  'kdheepak/lazygit.nvim',
  cmd = {
    'LazyGit',
    'LazyGitConfig',
    'LazyGitCurrentFile',
    'LazyGitFilter',
    'LazyGitFilterCurrentFile',
  },
  -- optional for floating window border decoration
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  -- setting the keybinding for LazyGit with 'keys' is recommended in
  -- order to load the plugin when the command is run for the first time
  keys = {
    { '<leader>gg', '<cmd>LazyGit<cr>', desc = 'LazyGit' },
  },
}
