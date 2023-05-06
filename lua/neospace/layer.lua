local vim = vim

local M = {}

local config_path = vim.fn.stdpath("config")

M.names = {}
M.modules = {}

function M:load(name, private)
  if self.modules[name] then
    return
  end

  local path = string.format("%s/%s/%s.lua", config_path, private and "private" or "layers", name)
  if vim.fn.filereadable(path) == 0 then
    return
  end
  local _, modules = pcall(dofile, path)
  if _ and modules then
    table.insert(self.names, name)
    self.modules[name] = modules
  elseif not _ then
    vim.notify(("dofile(%s) error: %s"):format(path, modules))
  end
end

function M:require(name, private)
  if package.loaded[name] then
    return package.loaded[name]
  end

  local path = string.format("%s/%s/lua/%s.lua", config_path, private and "private" or "layers", name)
  if vim.fn.filereadable(path) == 0 then
    return
  end
  local _, load = pcall(dofile, path)
  if _ then
    package.loaded[name] = load or true
  else
    vim.notify(("dofile(%s) error: %s"):format(path, load))
    return
  end
  return load
end

function M:append(name, func, item)
  local module
  for _, plugins in pairs(self.modules) do
    for i = 1, #plugins do
      local plugin = plugins[i]
      if type(plugin)=='string' and plugin==name then
        module = {plugin}
        plugins[i] = module
        break
      elseif plugin[1] == name then
        module = plugin
      end
    end
  end

  assert(module, string.format("not have `%s` plugin", name))
  item = item or "init"
  assert(item=='init', string.format("not support `%s` config for `%s` plugin", item, name))
  if module[item]==nil then
    module[item] = func
  elseif type(module[item])=='function' then
    module[item] = {module[item], func}
  else
    table.insert(module[item], #module[item], func)
  end
end

function M:load_private()
  self:load("init", true)
end

function M:list() end

function M:info() end

return M
