local vim = vim
local map = require("neospace").map
local fun = require("neospace.fun")

if vim.fn.exists("g:neovide") == 0 then
  return
end
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
vim.g.neovide_input_macos_option_key_is_meta = 'only_left'

vim.g.gui_font_default_size = 21.5
vim.g.gui_font_size = vim.g.gui_font_default_size
vim.g.guifont_face = "Hack Nerd Font Mono"
vim.g.guifontwide_face = "LXGW Neo XiHei"
vim.g.linespace=6

local RefreshGuiFont = function()
  if type(vim.g.guifont_face)~='nil' then
    vim.opt.guifont = string.format('%s:h%s', vim.g.guifont_face, vim.g.gui_font_size)
  end
  if type(vim.g.guifontwide_face)~='nil' then
    vim.opt.guifontwide = string.format('%s:h%s', vim.g.guifontwide_face, vim.g.gui_font_size)
  end
end

local ResizeGuiFont = function(delta)
  vim.g.gui_font_size = vim.g.gui_font_size + delta
  RefreshGuiFont()
end

local ResetGuiFont = function()
  vim.g.gui_font_size = vim.g.gui_font_default_size
  RefreshGuiFont()
end

-- Call function on startup to set default value
ResetGuiFont()

-- Dynamic change font size

map({ "n", "i" }, "<A-=>", "", {
  callback = function()
    ResizeGuiFont(0.5)
  end,
})
map({ "n", "i" }, "<A-->", "", {
  callback = function()
    ResizeGuiFont(-0.5)
  end,
})
map({ "n", "i" }, "<A-0>", "", {
  callback = function()
    ResetGuiFont()
  end,
})

-- system clipboard {{{
vim.g.neovide_input_use_logo = true
vim.cmd("set clipboard+=unnamedplus")

-- copy
map("", "<D-c>", '"+y')

-- pasta
vim.api.nvim_set_keymap("", "<D-v>", "+p<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("!", "<D-v>", "<C-R>+", { noremap = true, silent = true })
vim.api.nvim_set_keymap("t", "<D-v>", "<C-R>+", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<D-v>", "<C-R>+", { noremap = true, silent = true })

-- undo
map("n", "<D-z>", '"u')
map("i", "<D-z>", "<Esc>ua")

-- system clipboard }}}

map("n", "<leader>tw", "<cmd>let g:neovide_fullscreen = !g:neovide_fullscreen<cr>", {})
