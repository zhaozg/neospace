scriptencoding utf-8

let g:neospace = get(g:, 'neospace', {})
let g:neospace.base = $HOME.'/Private/neospace'
let g:neospace.version = '0.0.1'

" Identify platform {
let g:neospace.os = {}
let g:neospace.os.mac = has('macunix')
let g:neospace.os.linux = has('unix') && !has('macunix') && !has('win32unix')
let g:neospace.os.windows = has('win32') || has('win64')
" }

" Windows Compatible {
" On Windows, also use '.vim' instead of 'vimfiles'; this makes synchronization
" across (heterogeneous) systems easier.
if g:neospace.os.windows
  set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
endif
" }

set runtimepath+=$HOME/Private/neospace

call neospace#begin()
call neospace#end()

