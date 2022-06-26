local vim = vim

vim.o.guifont='FiraCode Nerd Font Mono:h18.5'
vim.g.neovide_fullscreen = true
vim.g.neovide_no_idle = false
vim.g.neovide_profiler = false
vim.g.neovide_touch_drag_timeout = 0.1
vim.g.neovide_cursor_animation_length = 0.1
vim.g.neovide_cursor_trail_length = 0.1
vim.g.neovide_cursor_unfocused_outline_width = 0.1
vim.g.neovide_cursor_antialiasing = false
vim.g.neovide_cursor_vfx_mode = ""
vim.g.neovide_input_use_logo=true

vim.cmd("set clipboard+=unnamedplus")

-- system clipboard
vim.keymap.set('',  '<D-c>', '"+y')
vim.keymap.set('n', '<D-v>', '"+p')
vim.cmd("inoremap <D-v> <c-r>+")
vim.cmd("cnoremap <D-v> <c-r>+")
--use <c-r> to insert original character without triggering things like auto-pairs
vim.cmd("inoremap <D-r> <c-v>")
