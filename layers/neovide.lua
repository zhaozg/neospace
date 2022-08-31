local vim = vim
local map = require'neospace'.map

vim.o.guifont = "Hack Nerd Font:h19"
vim.g.neovide_remember_window_size = true
vim.g.neovide_fullscreen = true
vim.g.neovide_no_idle = false
vim.g.neovide_profiler = false
vim.g.neovide_touch_drag_timeout = 0.1
vim.g.neovide_cursor_animation_length = 0.1
vim.g.neovide_cursor_trail_length = 0.1
vim.g.neovide_cursor_unfocused_outline_width = 0.1
vim.g.neovide_cursor_antialiasing = false
vim.g.neovide_cursor_vfx_mode = ""
vim.g.neovide_input_use_logo = true

vim.cmd("set clipboard+=unnamedplus")

-- system clipboard
map("", "<D-c>", '"+y')
map("n", "<D-v>", '"+p')
map({"i", "c"}, "<D-v>", '<c-r>+')
--use <c-r> to insert original character without triggering things like auto-pairs
map("i", "<D-r>", "<c-v>")
