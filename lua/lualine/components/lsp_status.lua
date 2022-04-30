-- displays the status of lsp
local vim = vim
local LspStatus = require('lualine.component'):extend()

function LspStatus:init(options)
    LspStatus.super.init(self, options)
end

function LspStatus:update_status()
  return require('lsp-status').status()
end

LspStatus.isEnabled = function() return #vim.lsp.buf_get_clients() > 0 end

return LspStatus
