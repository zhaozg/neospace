vim.cmd([[
augroup fmtlua
  autocmd!
  autocmd filetype lua setlocal ts=2 sw=2 et tw=79 fen fdm=syntax
augroup END
]])
