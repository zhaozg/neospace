if executable('astyle')
  if !exists("g:neoformat_c_astyle")
    let g:neoformat_c_astyle = {
          \ 'exe': 'astyle',
          \ 'args': ['--mode=c', '--style=allman', '--indent=spaces=2'],
          \ 'stdin': 1
          \ }
  endif
  if !exists("g:neoformat_cpp_astyle")
    let g:neoformat_c_astyle = {
          \ 'exe': 'astyle',
          \ 'args': ['--mode=c', '--style=allman', '--indent=spaces=2'],
          \ 'stdin': 1
          \ }
  endif
  let g:neoformat_enabled_c = ['astyle']
  let g:neoformat_enabled_cpp = ['astyle']
endif

augroup fmtc
  autocmd!
  autocmd filetype c,cpp setlocal ts=2 sw=2 et tw=79 fen fdm=syntax
  autocmd filetype make setlocal ts=8 sw=8 noet tw=79 fen fdm=marker
  autocmd BufRead,BufNewFile CMakelists.txt setlocal filetype=cmake
  autocmd filetype cmake setlocal foldmethod=marker
augroup END
