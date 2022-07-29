local vim = vim

local M = {}

local config_path = vim.fn.stdpath('config')

M.names = {}
M.modules = {}

function M:load(name, private)
  if self.modules[name] then
    return
  end

  local path = string.format("%s/%s/%s.lua",
                             config_path,
                             private and "private" or "layers",
                             name)
  if vim.fn.filereadable(path)==0 then return end
  local modules = dofile(path)
  if modules then
    table.insert(self.names, name)
    self.modules[name] = modules
  end
end

function M:require(name, private)
  if package.loaded[name] then
    return package.loaded[name]
  end

  local path = string.format("%s/%s/lua/%s.lua",
                             config_path,
                             private and "private" or "layers",
                             name)
  if vim.fn.filereadable(path)==0 then return end
  local load = dofile(path) or true
  if load then
    package.loaded[name] = load
  end
  return load
end

function M:load_private()
  self:load('init', true)
end

function M:list()
end

function M:info()
end

return M
