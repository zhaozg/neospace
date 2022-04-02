local vim = vim
local fn  = vim.fn   -- to call Vim functions e.g. fn.bufnr()

vim.o.guifont='Hack Nerd Font Mono:h16'
vim.g.neovide_fullscreen = true
vim.g.neovide_cursor_antialiasing = false
vim.g.neovide_cursor_vfx_mode = "railgun"
vim.g.neovide_input_use_logo=true

vim.cmd("set clipboard+=unnamedplus")

-- system clipboard
vim.keymap.set('',  '<D-c>', '"+y')
vim.keymap.set('n', '<D-v>', '"+p')
vim.cmd("inoremap <D-v> <c-r>+")
vim.cmd("cnoremap <D-v> <c-r>+")
--use <c-r> to insert original character without triggering things like auto-pairs
vim.cmd("inoremap <D-r> <c-v>")

