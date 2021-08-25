local vim = vim
local cmd = vim.cmd  -- to execute Vim commands e.g. cmd('pwd')
local fn  = vim.fn   -- to call Vim functions e.g. fn.bufnr()
local g   = vim.g

-- set neospace
g.neospace = g.neospace or {}
g.neospace.base = fn.fnamemodify(fn.resolve(fn.expand('<sfile>:p')), ':h')
g.neospace.version = '0.1.0'

g.neospace.macos = fn.has('macunix')
g.neospace.linux = fn.has('unix') and (not fn.has('macunix'))
                                  and not fn.has('win32unix')
g.neospace.windows = fn.has('win32') or fn.has('win64')

if vim.fn.filereadable('.nvimrc')==1 then
  vim.cmd("source .nvimrc")
end

-- map leader to Space
vim.cmd("let mapleader = ' '")
vim.cmd('let maplocalleader = ","')

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

-- load plugins
local user = require("user")
user.setup()

for _, name in pairs(layer.names) do
  local modules = layer.modules[name]
  for _ = 1, #modules do
    user.use (modules[_])
  end
end

