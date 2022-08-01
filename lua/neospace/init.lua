local M = {}

local fn = vim.fn -- to call Vim functions e.g. fn.bufnr()

M.version = "0.1.0"
M.macos = fn.has("macunix")
M.linux = fn.has("unix") and (not fn.has("macunix")) and not fn.has("win32unix")
M.windows = fn.has("win32") or fn.has("win64")

return M
