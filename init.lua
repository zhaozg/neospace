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
local function setup_global()
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
end

-- 动态加载本地配置
local function setup_local()
  -- 检测当前项目根目录（假设通过 .git 标识）
  local project_root = vim.fn.finddir(".git", ".;")
  if project_root == "" then return end -- 非项目目录，跳过

  -- 拼接本地配置文件路径（例如项目根目录的 .lazy.nvim.lua）
  local local_config_path = vim.fn.fnamemodify(project_root, ":h") .. "/.lazy.nvim.lua"
  if vim.fn.filereadable(local_config_path) == 0 then return end -- 文件不存在，跳过

  -- 加载本地配置
  local local_config = dofile(local_config_path)

  -- 合并本地插件到全局配置（优先级：本地 > 全局）
  require("lazy").setup(
    {
      { import = local_config },-- 本地插件
    },
    {
      -- 可选：本地插件安装到项目目录下（避免污染全局）
      root = project_root .. "/.nvim-plugins",
    })
end

setup_local()
setup_global()
require('neospace.leader')
