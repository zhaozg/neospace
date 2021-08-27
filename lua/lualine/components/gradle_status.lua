-- displays the status of gradle project, from vim-android
local vim = vim
local GradleStatus = require('lualine.component'):new()

GradleStatus.update_status = function()
  local status
  if vim.g.gradle_sync_on_load == 1 and type(vim.fn['gradle#statusLine'])=='function' then
    status = vim.fn['gradle#statusLine']()
  end
  return status
end

GradleStatus.isEnabled = function() return vim.g.gradle_sync_on_load == 1 end

return GradleStatus
