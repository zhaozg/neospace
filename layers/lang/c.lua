vim.cmd([[
augroup fmtc
  autocmd!
  autocmd filetype c,cpp setlocal ts=2 sw=2 et tw=79 fen fdm=syntax
  autocmd filetype make setlocal ts=8 sw=8 noet tw=79 fen fdm=marker
  autocmd BufRead,BufNewFile CMakelists.txt setlocal filetype=cmake
  autocmd filetype cmake setlocal foldmethod=marker
augroup END
]])
