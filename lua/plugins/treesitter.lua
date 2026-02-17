return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile", "SessionLoadPost" },
  config = function()
    local has_configs, configs = pcall(require, "nvim-treesitter.configs")

    if has_configs then
      -- Old API (master branch): modules managed by the plugin
      require("nvim-treesitter.install").prefer_git = true
      ---@diagnostic disable-next-line: missing-fields
      configs.setup({
        ensure_installed = {
          "bash",
          "c",
          "cpp",
          "diff",
          "html",
          "javascript",
          "lua",
          "luadoc",
          "markdown",
          "python",
          "vim",
          "vimdoc",
        },
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
      })
    else
      -- New API (main branch): use Neovim built-in treesitter
      require("nvim-treesitter").setup({})
      vim.api.nvim_create_autocmd("FileType", {
        callback = function()
          pcall(vim.treesitter.start)
          if vim.treesitter.query.get(vim.treesitter.language.get_lang(vim.bo.filetype) or "", "indents") then
            vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
      })
    end
  end,
}
