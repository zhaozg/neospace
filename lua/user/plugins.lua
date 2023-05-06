-- https://github.com/faerryn/plogins.nvim/blob/master/lua/plogins.lua
local vim = vim
local notify = vim.notify
local git = require("user.git")

local M = {}

local function run(scripts, title)
  local ret, msg, typ
  typ = type(scripts)
  assert(typ=='function' or typ=='table', string.format("invalid %s to run", title or "Lua"))
  if typ =='function' then
     ret, msg = pcall(scripts)
  elseif typ=='table' and #scripts > 0 then
    ret = true
    for i=1, #scripts do
      ret, msg = pcall(scripts[i])
      if not ret then
        break
      end
    end
  end
  return ret, msg
end

local function packadd_do(plugin)
  local cmd = ("packadd %s"):format(vim.fn.fnameescape(plugin.name))
  local _, err = pcall(vim.cmd, cmd)
  if not _ then
    notify(("packadd %s fail with:\n%s\n"):format(plugin.name, err))
  elseif plugin.packadd_hook then
    if plugin.packadd_init then
      local ret, msg = run(plugin.packadd_init)
      if not ret then
        notify(("packadd init %s fail: %s"):format(plugin.name, msg))
      end
    end
    local ret, msg = pcall(plugin.packadd_hook)
    if not ret then
      notify(("packadd hook %s fail: %s"):format(plugin.name, msg))
    end
  end
end

local function packadd_ft(plugin)
  vim.api.nvim_create_autocmd("FileType", {
    pattern = plugin.ft,
    callback = function()
      packadd_do(plugin)
    end,
  })
end

local function packadd_on(plugin)
  vim.api.nvim_create_autocmd("CmdUndefined", {
    pattern = plugin.on,
    callback = function()
      packadd_do(plugin)
    end,
  })
end

local function packadd(plugin)
  if plugin.ft then
    packadd_ft(plugin)
  elseif plugin.on then
    packadd_on(plugin)
  else
    packadd_do(plugin)
  end
end

local function helptags(plugin)
  local docdir = plugin.install_path .. "/doc"
  if vim.loop.fs_stat(docdir) then
    vim.cmd(("helptags %s"):format(vim.fn.fnameescape(docdir)))
  end
end

local function subset(a, b)
  for x, y in pairs(a) do
    if type(x) == "number" then
      x = y
    end
    if b[x] == nil then
      return false
    end
  end
  return true
end

local function scandir(path)
  local entries = {}
  local handle = vim.loop.fs_scandir(path)
  for entry in vim.loop.fs_scandir_next, handle do
    table.insert(entries, entry)
  end
  return entries
end

local function recursively_delete(path)
  local stat = vim.loop.fs_stat(path)
  if stat.type == "directory" then
    for _, entry in ipairs(scandir(path)) do
      recursively_delete(("%s/%s"):format(path, entry))
    end
    vim.loop.fs_rmdir(path)
  else
    vim.loop.fs_unlink(path)
  end
end

local function chdir_do(dir, fun, callback)
  local async = require("user.async")
  if type(fun) == "function" then
    local ret, msg = pcall(fun)
    callback(ret, msg)
  elseif type(fun) == "string" then
    async.run(fun, {
      cwd = dir,
      args = {},
    }, callback)
  elseif type(fun) == "table" then
    local cmd = table.remove(fun, 1)
    async.run(cmd, {
      cwd = dir,
      args = fun,
    }, callback)
  else
    error("Can't run " .. tostring(fun))
  end
end

local function install(pack, callback)
  if pack.upgrade_hook then
    chdir_do(pack.install_path, pack.upgrade_hook, function(ret, msg)
      vim.defer_fn(function()
        callback(ret, msg)
      end, 0)
    end)
  end
end

function M.manage(plugins, options)
  options = options or {}
  local plugins_directory = options.plugins_directory or ("%s/site/pack/user/opt"):format(vim.fn.stdpath("data"))
  local repo_base = options.repo_base or "https://github.com"

  local activated_sources = {}
  local pending_sources = {}

  local function try_activate(plugin)
    if plugin.enable == nil then
      plugin.enable = true
    end
    if subset(plugin.packadd_after, activated_sources) then
      if plugin.enable then
        packadd(plugin)
        activated_sources[plugin.name] = true
      else
        activated_sources[plugin.name] = false
      end
      pending_sources[plugin.name] = nil
      return true
    else
      pending_sources[plugin.name] = true
      return false
    end
  end

  local function plugin_check(plugin)
    if plugin.repo == nil and string.match(plugin.name, "^[^/]+/[^/]+$") then
      plugin.repo = ("%s/%s.git"):format(repo_base, plugin.name)
    end
    assert(plugin.repo)
  end

  local count = 0
  for _ = 1, #plugins do
    local plugin = plugins[_]
    plugin.upgrade_hook = plugin.upgrade_hook or plugin.install or function() end
    plugin.packadd_init = plugin.packadd_init or plugin.init
    plugin.packadd_hook = plugin.packadd_hook or plugin.config or function() end
    plugin.packadd_after = plugin.packadd_after or plugin.after or {}
    if type(plugin.packadd_after) == "string" then
      plugin.packadd_after = { plugin.packadd_after }
    end

    plugin.install_path = ("%s/%s"):format(plugins_directory, plugin.name)
    if not plugins[plugin.name] then
      plugins[plugin.name] = plugin
    end
    if vim.loop.fs_stat(plugin.install_path) then
      try_activate(plugin)
    else
      count = count + 1
      plugin_check(plugin)
      git.clone(plugin, function()
        helptags(plugin)
        count = count - 1
        install(plugin, function()
          try_activate(plugin)
          notify(("%s installed"):format(plugin.name))
        end)
        if count == 0 then
          notify("All plugins installed")
        end
      end)
    end
  end

  local progress = true
  while progress do
    progress = false
    for source, _ in pairs(pending_sources) do
      progress = try_activate(plugins[source]) or progress
    end
  end
  if options.loaded then
    local _, msg = pcall(options.loaded)
    if not _ then
      notify(("ERR: %s"):format(msg))
    end
  end

  local function upgrade()
    local cnt = 0
    for source, _ in pairs(activated_sources) do
      local plugin = plugins[source]
      cnt = cnt + 1

      plugin_check(plugin)
      git.update(plugin, function(current, update)
        cnt = cnt - 1
        if current ~= update then
          helptags(plugin)

          install(plugin, function()
            notify(("%s upgraded"):format(source))
          end)
        end
        if cnt == 0 then
          notify("All plugins upgraded")
        end
      end)
    end
  end

  local function autoremove()
    local entries = scandir(plugins_directory)
    for _, entry in ipairs(entries) do
      local subs = scandir(("%s/%s"):format(plugins_directory, entry))
      for _, sub in ipairs(subs) do
        local plugin = string.format("%s/%s", entry, sub)
        if plugins[plugin] == nil then
          recursively_delete(("%s/%s"):format(plugins_directory, plugin))
          notify(("%s removed"):format(plugin))
        end
      end
    end
  end

  return { upgrade = upgrade, autoremove = autoremove }
end

return M
