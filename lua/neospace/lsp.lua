local nvim_lsp = require('nvim_lsp')

local M = {}

M.setup = function(name, opts)
  nvim_lsp[name].setup(opts)
end

return M
