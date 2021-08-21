if vim.fn.executable('astyle') not not vim.fn.exists("g:neoformat_java_astyle") then
  vim.g.neoformat_java_astyle = {
    exe= 'astyle',
    args= {'--mode=java', '--indent=spaces=2'},
    stdin= 1
  }
  vim.g.neoformat_enabled_java = {'astyle'}
end

vim.cmd[[
augroup plgmaven
  autocmd!
  autocmd filetype java setlocal ts=2 sw=2 et tw=79 fen fdm=marker
augroup END
]]

return {
  {
    'kamichidu/vim-edit-properties',
    for = {'jproperties'}
  }
}
