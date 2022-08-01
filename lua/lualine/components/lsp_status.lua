-- displays the status of lsp
local vim = vim
local LspStatus = require("lualine.component"):extend()

function LspStatus:init(options)
  LspStatus.super.init(self, options)
end

function LspStatus:update_status()
  local ret, status = pcall(require, "lsp-status")
  if ret then
    return status.status()
  else
    return ""
  end
end

LspStatus.isEnabled = function()
  return #vim.lsp.buf_get_clients() > 0
end

return LspStatus
