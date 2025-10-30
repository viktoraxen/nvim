local layouts = require('plugins.snacks.layouts')

return {
    -- dev = true,
    -- "gitter-nvim",
    "viktoraxen/gitter-nvim",
    dependencies = { "folke/snacks.nvim" },
    opts = {
        layout = layouts.adaptive_width(layouts.git_wide, layouts.narrow)
    },
    keys = {
        { "<leader>gg", "<cmd>Gitter<cr>", desc = "Gitter" }
    },
    cmd = { "Gitter" },
}
