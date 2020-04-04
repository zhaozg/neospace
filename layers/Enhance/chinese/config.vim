function! s:wordcount()
    return wordcount()['chars'] . '字 ' . wordcount()['words'] . '句'
endfunction

command! WordCount echo s:wordcount()
