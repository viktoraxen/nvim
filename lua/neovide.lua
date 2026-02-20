vim.o.guifont = "UbuntuMono Nerd Font Propo:h14:w1.0"
vim.opt.linespace = 23

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

Snacks.scroll.disable()
