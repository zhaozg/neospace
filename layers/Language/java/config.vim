if executable('astyle') && exists("g:neoformat_java_astyle")==0
  let g:neoformat_java_astyle = {
        \ 'exe': 'astyle',
        \ 'args': ['--mode=java', '--indent=spaces=2'],
        \ 'stdin': 1
        \ }
  let g:neoformat_enabled_java = ['astyle']
endif

augroup plgmaven
  autocmd!
  autocmd filetype java setlocal ts=2 sw=2 et tw=79 fen fdm=marker
augroup END
