return {
  win = {
    keys = {
      i_ctrl_h = { "<c-h>", "<c-s-w>", mode = "i", expr = true },
      i_ctrl_k = { "<c-k>", { "hist_up" }, mode = { "i", "n" } },
      i_ctrl_j = { "<c-j>", { "hist_down" }, mode = { "i", "n" } },
      i_ctrl_l = { "<c-l>", { "confirm" }, mode = { "i", "n" } },
      i_ctrl_c = { "<c-c>", "cancel", mode = "i", expr = true },
    },
    relative = "cursor",
    row = -3,
    col = 0,
  },
}
