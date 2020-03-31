augroup luadev
  autocmd!
  autocmd filetype lua setlocal ts=2 sw=2 et tw=79 fen fdm=syntax
  autocmd filetype lua call neospace#leader#register('l', {'name': 'luadev'}, 1)
  autocmd filetype lua nmap <buffer> <localleader>ll <Plug>(Luadev-RunLine)
  autocmd filetype lua nmap <buffer> <localleader>lr <Plug>(Luadev-Run
  autocmd filetype lua nmap <buffer> <localleader>lw <Plug>(Luadev-RunWord)
  autocmd filetype lua nmap <buffer> <localleader>lc <Plug>(Luadev-Complete)
augroup END

