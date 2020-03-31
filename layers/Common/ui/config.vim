scriptencoding=utf-8

" whichKey {{{
function! StartifyEntryFormat()
  if exists('g:loaded_webdevicons')
    return 'WebDevIconsGetFileTypeSymbol(absolute_path) ." ". entry_path'
  else
    return 'entry_path'
  endif
endfunction

let g:mapleader = "\<Space>"
let g:maplocalleader = ','
let g:neospace_leader_hspace = 4
let g:nepspace_leader_sep = '▸'
let g:neospace_leader_floating_opts = { 'row': '-1' }


nnoremap <silent> <leader>      :<c-u>WhichKey '<Space>'<CR>
nnoremap <silent> <localleader> :<c-u>WhichKey ','<CR>

vnoremap <silent> <leader>      :<c-u>WhichKeyVisual '<Space>'<CR>
vnoremap <silent> <localleader> :<c-u>WhichKeyVisual ','<CR>

autocmd VimEnter * call which_key#register(' ', "g:neospace_map")
autocmd VimEnter * call which_key#register(',', "g:neospace_lmap")

" for quickfix
nnoremap <leader>tq <Plug>(qf_qf_toggle)
vnoremap <leader>tq <Plug>(qf_qf_toggle)

" for fugitive
autocmd FileType gitcommit  noremap <buffer> <leader> <Plug>leaderguide-buffer

" for vista
autocmd BufEnter __vista__ noremap <buffer> <leader> <Plug>leaderguide-buffer

highlight default link WhichKey          Function
highlight default link WhichKeySeperator DiffAdded
highlight default link WhichKeyGroup     Keyword
highlight default link WhichKeyDesc      Identifier

highlight default link WhichKeyFloating Pmenu
" }}}

autocmd StdinReadPre * let s:std_in=1

" open a NERDTree automatically when vim starts up if no files were specified
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" open NERDTree automatically when vim starts up on opening a directory
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif

  " Open quickfix window automatically when something is feeded
  autocmd QuickFixCmdPost *
        \ if !len(filter(range(1, winnr('$')), 'getwinvar(v:val, "&ft") == "qf"'))
        \| copen 8
        \|endif

  " Close vim if the last edit buffer is closed, i.e., close NERDTree,
  " undotree, quickfix etc automatically.
  " autocmd BufEnter * if 0 == len(filter(range(1, winnr('$')), 'empty(getbufvar(winbufnr(v:val), "&bt"))')) | qa! | endif
  " Bug here. See #269.
  " =====================================
  autocmd BufEnter * call MyLastWindow()
  function! MyLastWindow()
    " if the window is quickfix/locationlist
    let l:bt_blacklist = ['quickfix', 'locationlist']
    let l:ft_blocklist = ['quickmenu']
    if index(l:bt_blacklist, &buftype) >= 0 || index(l:ft_blocklist, &filetype) >= 0
      " if this window is last on screen quit without warning
      if winnr('$') == 1
        quit!
      endif
    endif
    " Sometimes when the last window is nerdtree with another buffer exists,
    " vim will close automatically. See #283
    " To reproduce:
    " 1. vim foo.txt
    " 2. NERDTreeFind
    " 3. :bd
    " that's due to winnr('$) = 1, so diable it for now until a better
    " solution is found.
    " if (winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree()) | q! | endif
  endfunction

  " http://vim.wikia.com/wiki/Always_start_on_first_line_of_git_commit_message
  autocmd BufEnter * if &filetype == "gitcommit" | call setpos('.', [0, 1, 1, 0]) | endif

" http://stackoverflow.com/questions/5933568/disable-blinking-at-the-first-last-line-of-the-file
autocmd GUIEnter * set t_vb=

augroup neospace_asyncrun_quickfix
  " Auto rebuild C/C++ project when source file is updated, asynchronously
  "autocmd BufWritePost *.c,*.cpp,*.h
              "\ let dir=expand('<amatch>:p:h') |
              "\ if filereadable(dir.'/Makefile') || filereadable(dir.'/makefile') |
              "\   execute 'AsyncRun -cwd=<root> make -j8' |
              "\ endif
  " Auto toggle the quickfix window
  autocmd User AsyncRunStop
              \ if g:asyncrun_status=='failure' |
              \   execute('call asyncrun#quickfix_toggle(8, 1)') |
              \ else |
              \   execute('call asyncrun#quickfix_toggle(8, 0)') |
              \ endif
augroup END

" Define new accents

function! Get_asyncrun_running()

  let async_status = g:asyncrun_status

  if async_status == 'running'
    let async_status = ''
  elseif async_status == 'success' || async_status == 'stopped'
    let async_status = ''
  elseif async_status == 'failure'
    let async_status = ''
  endif

  "AirlineRefresh
  return async_status
endfunction

call airline#parts#define_function('asyncrun_status', 'Get_asyncrun_running')
let g:airline_section_warning = airline#section#create([
      \ 'asyncrun_status',
      \ 'ycm_warning_count',
      \ 'syntastic-warn',
      \ 'neomake_warning_count',
      \ 'ale_warning_count',
      \ 'whitespace'])

function! s:TogBG()
  let &background = ( &background == "dark"? "light" : "dark" )
endfunction

noremap <Plug>ToggleBackground  :call <SID>TogBG()<cr>
nmap <leader>tb <Plug>ToggleBackground
