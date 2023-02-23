local M = {}
local vim = vim
local uv = vim and vim.loop or require("luv")
local co = coroutine

M.uv = uv

function M.run(cmd, options, callback)
  local stdout = uv.new_pipe(false)
  local handle, chunks
  assert(options.args)
  options.stdio = options.stdio or { nil, stdout }
  handle = uv.spawn(cmd, options, function(code, signal)
    uv.close(handle)
    uv.close(stdout)
    if callback then
      --code, chunks, signal
      callback(code, chunks and table.concat(chunks) or nil, signal)
    end
  end)
  chunks = {}
  uv.read_start(stdout, function(err, chunk)
    assert(not err, err)
    if chunk then
      chunks[#chunks + 1] = chunk
    end
  end)
end

-- https://github.com/iamcco/async-await.lua/blob/master/lua/async-await.lua
local function next_step(thread, success, ...)
  local res = { co.resume(thread, ...) }
  assert(res[1], unpack(res, 2))
  if co.status(thread) ~= "dead" then
    res[2](function(...)
      next_step(thread, success, ...)
    end)
  else
    success(unpack(res, 2))
  end
end

M.async = function(func)
  assert(type(func) == "function", "async params must be function")
  local res = {
    is_done = false,
    data = nil,
    cb = nil,
  }
  next_step(co.create(func), function(...)
    res.is_done = true
    res.data = { ... }
    if res.cb ~= nil then
      res.cb(unpack(res.data))
    end
  end)
  return function(cb)
    if res.is_done then
      cb(unpack(res.data))
    else
      res.cb = cb
    end
  end
end

M.await = function(async_cb)
  assert(type(async_cb) == "function", "await params must be function")
  return co.yield(async_cb)
end

return M
