return {
  "xzbdmw/colorful-menu.nvim",
  event = "InsertEnter",
  opts = {
    ls = {
      lua_ls = {
        arguments_hl = "@comment",
      },
      vtsls = {
        extra_info_hl = "@comment",
      },
      clangd = {
        extra_info_hl = "@comment",
        align_type_to_right = true,
        import_dot_hl = "@comment",
        preserve_type_when_truncate = true,
      },
      basedpyright = {
        extra_info_hl = "@comment",
      },
      fallback = true,
      fallback_extra_info_hl = "@comment",
    },
    fallback_highlight = "@variable",
    max_width = 60,
  },
}
