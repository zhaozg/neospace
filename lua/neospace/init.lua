local M = {}

local fn = vim.fn -- to call Vim functions e.g. fn.bufnr()

M.version = "0.1.0"
M.macos = fn.has("mac")
M.linux = fn.has("linux")
M.windows = fn.has("win32") or fn.has("win64")

local v = vim.version()
-- compat deprecated
if vim.version.gt(v, {0, 11, 0}) then
  vim.lsp.buf_get_clients = function(bufnr)
    return vim.lsp.get_clients({buffer=bufnr})
  end

  vim.lsp.get_active_clients =	vim.lsp.get_clients

  vim.tbl_flatten = function(t)
    return vim.iter(t):flatten():totable()
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

M.format = require('neospace.format')

return M
