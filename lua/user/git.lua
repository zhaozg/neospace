local M = {}

local async = require'user.async'
local uv = async.uv

function M.async_run(pack, args, callback)
  local cmd = 'git'
  table.insert(args, 1, pack.install_path)
  table.insert(args, 1, "-C")
  async.run(cmd, args, callback)
end

function M.current_branch(pack, callback)
  M.async_run(pack, {
    'rev-parse',
    '--abbrev-ref',
    'HEAD'
  }, function(code, branch)
    callback(branch, code)
  end)
end

function M.head_hash(pack, callback, remote)
  if remote then
    --get remote hash
    M.current_branch(pack, function(branch, code)
      assert(code==0)
      M.async_run(pack, {
        'rev-parse',
        '@{u}'
      }, function(code1, hash)
        assert(code1==0)
        callback(hash, code)
      end)
    end)
    return
  end
  -- get local head hash
  M.async_run(pack, {
    'rev-parse',
    'HEAD'
  }, function(code, hash)
    callback(hash, code)
  end)
end

function M.update(pack, callback)
  M.async_run(pack, {
    'pull',
    '--quiet'
  }, function(code)
    if code==0 then
      M.head_hash(pack, callback)
      return
    end
    callback(nil, code)
  end)
end

return M

