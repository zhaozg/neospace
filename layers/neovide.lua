local vim = vim
local map = require 'neospace'.map

if not vim.fn.exists('g:neovide') then
  return
end
vim.g.neovide_input_macos_alt_is_meta = true
vim.g.neovide_remember_window_size = true
vim.g.neovide_fullscreen = true
vim.g.neovide_hide_mouse_when_typing = true
vim.g.neovide_no_idle = false
vim.g.neovide_profiler = false
vim.g.neovide_touch_drag_timeout = 0.1
vim.g.neovide_cursor_animation_length = 0.1
vim.g.neovide_cursor_trail_length = 0.1
vim.g.neovide_cursor_unfocused_outline_width = 0.1
vim.g.neovide_cursor_antialiasing = false
vim.g.neovide_cursor_vfx_mode = ""
vim.g.neovide_input_use_logo = true

vim.g.gui_font_default_size = 19
vim.g.gui_font_size = vim.g.gui_font_default_size
vim.g.gui_font_face = "Hack Nerd Font Mono"

RefreshGuiFont = function()
  vim.opt.guifont = string.format("%s:h%s", vim.g.gui_font_face, vim.g.gui_font_size)
end

ResizeGuiFont = function(delta)
  vim.g.gui_font_size = vim.g.gui_font_size + delta
  RefreshGuiFont()
end

ResetGuiFont = function()
  vim.g.gui_font_size = vim.g.gui_font_default_size
  RefreshGuiFont()
end

-- Call function on startup to set default value
ResetGuiFont()

-- Dynamic change font size

map({ 'n', 'i' }, "<A-=>", "", {
  callback = function() ResizeGuiFont(0.5) end
})
map({ 'n', 'i' }, "<A-->", "", {
  callback = function() ResizeGuiFont(-0.5) end
})
map({ 'n', 'i' }, "<A-0>", "", {
  callback = function() ResetGuiFont() end
})

-- system clipboard {{{
vim.g.neovide_input_use_logo = true
vim.cmd("set clipboard+=unnamedplus")

-- copy
map("", "<D-c>", '"+y')

-- pasta
map("n", "<D-v>", '"+p')
map("i", "<D-v>", '<Esc>"+pa')
map("c", "<D-v>", '<c-r>+', {})
map("t", "<D-v>", '<c-\\><c-n>"+pa')

-- undo
map("n", "<D-z>", '"u')
map("i", "<D-z>", '<Esc>ua')

-- system clipboard }}}

map("n", "<leader>tw", '<cmd>let g:neovide_fullscreen = !g:neovide_fullscreen<cr>', {})
