local M = {}

local config_path = vim.fn.stdpath('config')

M.names = {}
M.modules = {}

function M:load(name)
  if self.modules[name] then
    return
  end
  table.insert(self.names, name)
  local path = string.format("%s/layers/%s.lua", config_path, name)
  local modules = dofile(path)

  self.modules[name] = modules
end

function M:list()
end

function M:info()
end

return M
