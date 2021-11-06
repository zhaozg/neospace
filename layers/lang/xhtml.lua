vim.cmd[[
augroup fmtxhtml
  autocmd!
  autocmd filetype xml,xhtml setlocal ts=2 sw=2 et tw=79 fen fdm=indent
augroup END
]]

