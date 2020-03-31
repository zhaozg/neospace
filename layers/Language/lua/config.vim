autocmd FileType lua call neospace#leader#register('d', {'name': '+doc'}, 1)
autocmd FileType lua nmap <buffer> <localleader>dg :! ldoc %:p; open %:h/doc/index.html<cr>
autocmd FileType lua setlocal foldmethod=syntax
