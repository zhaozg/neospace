local vim = vim
local M = {}

local async = require("user.async")

function M.async_run(pack, args, callback)
  local cmd = "git"
  table.insert(args, 1, pack.install_path)
  table.insert(args, 1, "-C")

  async.run(cmd, {
    args = args,
    cwd = pack.install_path,
    hide = true,
  }, callback)
end

function M.current_branch(pack)
  return vim.fn.system({ "git", "-C", pack.install_path, "rev-parse", "--abbrev-ref", "HEAD" })
end

function M.current_version(pack, remote, callback)
  local cmds = { "git", "-C", pack.install_path, "rev-parse" }
  if remote then
    cmds[#cmds + 1] = "@{u}"
  else
    cmds[#cmds + 1] = "HEAD"
  end
  if callback == nil then
    return vim.fn.system(cmds):gsub("\r", ""):gsub("\n", "")
  end
  M.async_run(pack, {
    "rev-parse",
    "@{u}",
  }, callback)
end

function M.clone(pack, callback)
  local cmd = "git"
  local args = {
    "clone",
    pack.repo,
    pack.install_path,
    "--depth",
    "9",
  }

  async.run(cmd, {
    args = args,
    hide = true,
  }, function(code, chunk, signal)
    vim.defer_fn(function()
      callback(code, chunk, signal)
    end, 0)
  end)
end

function M.update(pack, callback)
  local current = M.current_version(pack)
  M.async_run(pack, {
    "pull",
    "--depth",
    "9",
    "--force",
    "--rebase",
    "--quiet",
  }, function(code, chunk, signal)
    local update
    if code == 0 then
      vim.defer_fn(function()
        update = M.current_version(pack)
        callback(current, update, code, signal)
      end, 0)
    else
      vim.notify(("update %s fail: %d, %s, %d"):format(code, chunk or "", signal))
    end
  end)
end

return M
