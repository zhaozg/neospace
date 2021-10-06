local M  = {}
local vim = vim
local uv = vim and vim.loop or require'luv'

M.uv = uv

function M.run(cmd, args, callback)
  local stdout = uv.new_pipe(false)

  local handle, chunks
  handle = uv.spawn(cmd, {
    args = args,
    stdio = {nil, stdout},
  }, function (code, signal)
    uv.close(handle)
    uv.close(stdout)
    if callback then
      callback(code, chunks and table.concat(chunks) or nil, signal)
    end
  end)
  chunks = {}
  uv.read_start(stdout, function (err, chunk)
    assert(not err, err)
    if chunk then
      chunks[#chunks+1] = chunk
    end
  end)
end


return M
