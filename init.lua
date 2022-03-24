local vim = vim
local fn  = vim.fn   -- to call Vim functions e.g. fn.bufnr()

vim.g.loaded_python_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0

vim.g.python3_host_prog = 'python3'

--embed impatient comes from https://github.com/lewis6991/impatient.nvim
require('impatient')

local neospace = require'neospace'
-- set neospace
neospace.base = fn.fnamemodify(fn.resolve(fn.expand('<sfile>:p')), ':h')

if vim.fn.exists("g:neovide") then
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
end

if vim.fn.filereadable('.nvimrc')==1 then
  vim.cmd("source .nvimrc")
end

-- map leader to Space
vim.cmd("let mapleader = ' '")
vim.cmd('let maplocalleader = ","')

-- active map
require'neospace.leader'

-- active default layer --
local layer = require'neospace.layer'
layer:load('better')
layer:load('async')
layer:load('ui')
layer:load('theme')
layer:load('text')
layer:load('code')
layer:load('finder')
layer:load('git')
layer:load('lsp')
layer:load('treesitter')
layer:load('ale')
layer:load('debug')
layer:load('lang/markdown')

-- load plugins
local user = require("user")
user.setup()

for _, name in pairs(layer.names) do
  local modules = layer.modules[name]
  for _ = 1, #modules do
    user.use (modules[_])
  end
end

user.finish()

