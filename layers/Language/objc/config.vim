if executable('uncrustify')
  let g:neoformat_objc_uncrustify = {
        \ 'exe': 'uncrustify',
        \ 'args': ['-q', '-l OC'],
        \ 'stdin': 1,
        \ }
  let g:neoformat_objcpp_uncrustify = {
        \ 'exe': 'uncrustify',
        \ 'args': ['-q', '-l OC+'],
        \ 'stdin': 1,
        \ }
  let g:neoformat_enabled_objc = ['uncrustify']
  let g:neoformat_enabled_objcpp = ['uncrustify']
endif

augroup fmtobjc
  autocmd!
  autocmd filetype objc,objcpp setlocal ts=4 sw=4 et tw=79 fen fdm=syntax
augroup END

