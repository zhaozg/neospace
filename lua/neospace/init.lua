local M = {}

local fn = vim.fn -- to call Vim functions e.g. fn.bufnr()

M.version = "0.1.0"
M.macos = fn.has("macunix")
M.linux = fn.has("unix") and (not fn.has("macunix")) and not fn.has("win32unix")
M.windows = fn.has("win32") or fn.has("win64")

if vim.fn.filereadable(".nvim.lua") == 1 then
  local ctx = assert(loadfile(".nvim.lua"))
  ctx = assert(ctx())
  if ctx then
    M.init = ctx.init
    M.config = ctx.config
  else
    M.init = UserInit
    M.config = UserConfig
  end
end

return M
