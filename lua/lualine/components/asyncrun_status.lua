-- displays the status of asyncrun
local vim = vim
local AsyncRunStatus = require('lualine.component'):new()

AsyncRunStatus.update_status = function()
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
