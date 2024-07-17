return {
  'coffebar/neovim-project',
  opts = {
    projects = {
      '~/dev/*',
    },
    dashboard_mode = true,
    autosave_ignore_filetypes = {
      -- All buffers of these file types will be closed before the session is saved
      'ccc-ui',
      'gitcommit',
      'gitrebase',
      'qf',
      'FTerm',
      'lazygit',
    },
  },
  init = function()
    -- enable saving the state of plugins in the session
    vim.opt.sessionoptions:append 'globals' -- save global variables that start with an uppercase letter and contain at least one lowercase letter.
  end,
  dependencies = {
    { 'nvim-lua/plenary.nvim' },
    { 'nvim-telescope/telescope.nvim', tag = '0.1.4' },
    { 'Shatur/neovim-session-manager' },
  },
  lazy = false,
  priority = 100,
}
