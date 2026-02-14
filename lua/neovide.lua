vim.o.guifont = "UbuntuMono Nerd Font Propo:h14"
vim.opt.linespace = 15

vim.g.neovide_padding_left = 15
vim.g.neovide_padding_right = 15
vim.g.neovide_padding_top = 10

local background_color = string.format("#%06x", vim.api.nvim_get_hl(0, { name = "Normal" }).bg)

vim.g.neovide_title_background_color = background_color

vim.g.neovide_hide_mouse_when_typing = true
vim.g.neovide_cursor_animation_length = 0

local function change_scale_factor(delta)
  vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
end

vim.keymap.set("n", "<C-+>", function()
  change_scale_factor(1.1)
end)

vim.keymap.set("n", "<C-->", function()
  change_scale_factor(1 / 1.1)
end)

vim.g.terminal_color_0 = "#45475a"
vim.g.terminal_color_1 = "#f38ba8"
vim.g.terminal_color_2 = "#a6e3a1"
vim.g.terminal_color_3 = "#f9e2af"
vim.g.terminal_color_4 = "#89b4fa"
vim.g.terminal_color_5 = "#f5c2e7"
vim.g.terminal_color_6 = "#94e2d5"
vim.g.terminal_color_7 = "#bac2de"
vim.g.terminal_color_8 = "#585b70"
vim.g.terminal_color_9 = "#f38ba8"
vim.g.terminal_color_10 = "#a6e3a1"
vim.g.terminal_color_11 = "#f9e2af"
vim.g.terminal_color_12 = "#89b4fa"
vim.g.terminal_color_13 = "#f5c2e7"
vim.g.terminal_color_14 = "#94e2d5"
vim.g.terminal_color_15 = "#a6adc8"

Snacks.scroll.disable()
