let g:airline#extensions#wordcount#charset =
  \ get(g:, 'airline#extensions#wordcount#charset', '字')
let g:airline#extensions#wordcount#word =
  \ get(g:, 'airline#extensions#wordcount#word', '句')

function! airline#extensions#wordcount#formatters#cnfmt#format()
    return wordcount()['chars'] . g:airline#extensions#wordcount#charset
    \ . ' ' . wordcount()['words'] . g:airline#extensions#wordcount#word
endfunction

