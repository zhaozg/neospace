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

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end

vim.opt.rtp:prepend(lazypath)

-- map leader to Space
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- load private laoder
if neospace.load_private then
  neospace.load_private()
end

-- deprecated
vim.treesitter.query.get_query = vim.treesitter.query.get
vim.treesitter.query.parse_query = vim.treesitter.query.parse

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- import your plugins
    { import = "layers" },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "gruvbox" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})
