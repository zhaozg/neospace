local vim = vim
local fn = vim.fn -- to call Vim functions e.g. fn.bufnr()

vim.g.loaded_python_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0

vim.g.python3_host_prog = "python3"

vim.loader.enable()

local neospace = require("neospace")
-- set neospace
neospace.base = fn.fnamemodify(fn.resolve(fn.expand("<sfile>:p")), ":h")

if neospace.init then
  neospace.init()
end
-- map leader to Space
vim.cmd("let mapleader = ' '")
vim.cmd('let maplocalleader = ","')

-- active map
require("neospace.leader")

-- active default layer --
local layer = require("neospace.layer")

-- basic
layer:load("better")
layer:load("theme")
layer:load("async")
layer:load("ui")

-- commons
layer:load("text")
layer:load("treesitter")
layer:load("code")
layer:load("finder")
layer:load("git")
layer:load("fold")

-- enhance
layer:load("lsp")
layer:load("debug")
layer:load("ai")

-- language
layer:load("lang/markdown")
layer:load("lang/diagram")

-- misc
layer:load("tools")

if vim.fn.exists("g:neovide") then
  layer:load("neovide")
end

layer:load_private()

-- deprecated
vim.treesitter.query.get_query = vim.treesitter.query.get
vim.treesitter.query.parse_query = vim.treesitter.query.parse

-- load plugins
local user = require("user")

for _, name in pairs(layer.names) do
  local modules = layer.modules[name]
  if modules then
    for _ = 1, #modules do
      user.use(modules[_])
    end
  else
    print(("Error to load(%s) with %s"):format(name, modules))
  end
end

user.setup({
  loaded = function()
    if neospace.config then
      neospace.config()
    end
  end,
})
