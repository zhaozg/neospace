local M = {}

local fn = vim.fn -- to call Vim functions e.g. fn.bufnr()

M.version = "0.1.0"
M.macos = fn.has("macunix")
M.linux = fn.has("unix") and (not fn.has("macunix")) and not fn.has("win32unix")
M.windows = fn.has("win32") or fn.has("win64")

if vim.fn.filereadable(".nvim.lua") == 1 then
  local ctx = assert(loadfile(".nvim.lua"))
  ctx = ctx()
  if ctx then
    M.init = ctx.init
    M.config = ctx.config
  end
end

local default_map_opts = { noremap = true, silent = true }
M.default_map_opts = default_map_opts

M.map = function(bufnr, mode, keys, cmd, options)
  if tonumber(bufnr) == bufnr then
    if type(mode) == "table" then
      for _, v in pairs(mode) do
        vim.api.nvim_buf_set_keymap(bufnr, v, keys, cmd, options or default_map_opts)
      end
    else
      vim.api.nvim_buf_set_keymap(bufnr, mode, keys, cmd, options or default_map_opts)
    end
  else
    mode, keys, cmd, options = bufnr, mode, keys, cmd
    if type(mode) == "table" then
      for _, v in pairs(mode) do
        vim.api.nvim_set_keymap(v, keys, cmd, options or default_map_opts)
      end
    else
      vim.api.nvim_set_keymap(mode, keys, cmd, options or default_map_opts)
    end
  end
end

return M
