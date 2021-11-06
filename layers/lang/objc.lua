vim.cmd[[
augroup fmtobjc
  autocmd!
  autocmd filetype objc,objcpp setlocal ts=4 sw=4 et tw=79 fen fdm=syntax
augroup END
]]

