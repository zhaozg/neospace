-- displays the status of asyncrun
local vim = vim
local AsyncRunStatus = require('lualine.component'):extend()


function AsyncRunStatus:init(options)
    AsyncRunStatus.super.init(self, options)
end

function AsyncRunStatus:update_status()
  local async_status = vim.g.asyncrun_status

  if async_status == 'running' then
    async_status = ''
  elseif async_status == 'success' or async_status == 'stopped' then
    async_status = ''
  elseif async_status == 'failure' then
    async_status = ''
  end

  return async_status
end

return AsyncRunStatus
