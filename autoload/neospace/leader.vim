" Define prefix dictionary
let g:neospace_map  = get(g:, 'neospace_map', {})
let g:neospace_lmap = get(g:, 'neospace_lmap', {})

let g:neospace_leader_map = {}
let g:neospace_leader_map[g:mapleader] = g:neospace_map
let g:neospace_leader_map[g:maplocalleader] = g:neospace_lmap

"for s:i in range(1, 9)
"    let g:neospace_map[s:i] = [ s:i.'wincmd w', 'windows '.s:i ]
"endfor

let g:neospace_map['?'] = [ 'Maps',  'keymaps' ]

let g:neospace_map['b'] = { 'name' : '+buffer' ,
      \ '1' : ['b1'        , 'buffer 1']        ,
      \ '2' : ['b2'        , 'buffer 2']        ,
      \ '3' : ['b3'        , 'buffer 3']        ,
      \ '4' : ['b4'        , 'buffer 4']        ,
      \ '5' : ['b5'        , 'buffer 5']        ,
      \ '6' : ['b6'        , 'buffer 6']        ,
      \ '7' : ['b7'        , 'buffer 7']        ,
      \ '8' : ['b8'        , 'buffer 8']        ,
      \ '9' : ['b9'        , 'buffer 9']        ,
      \ 'd' : ['bd'        , 'delete-buffer']   ,
      \ 'f' : ['bfirst'    , 'first-buffer']    ,
      \ 'h' : ['Startify'  , 'home-buffer']     ,
      \ 'k' : ['bw'        , 'kill-buffer']     ,
      \ 'l' : ['blast'     , 'last-buffer']     ,
      \ 'n' : ['bnext'     , 'next-buffer']     ,
      \ 'p' : ['bprevious' , 'previous-buffer'] ,
      \ 'b' : ['Buffers'   , 'fzf-buffer']      ,
      \ '?' : ['Buffers'   , 'fzf-buffer']      ,
      \ }

" code Splitjoin, cscope, NERDCommenter
let g:neospace_map['c'] = { 'name' : '+code' }

let g:neospace_map['d'] = { 'name' : '+docs/dbg' }

let g:neospace_map['e'] = { 'name' : '+errors' }
let g:neospace_map['f'] = { 'name' : '+finder' }
let g:neospace_map['g'] = { 'name' : '+git' }
let g:neospace_map['h'] = { 'name' : '+help/hunk' }
let g:neospace_map['j'] = { 'name' : '+jump'                                     ,
      \ 'f' : ['<Plug>(easymotion-overwin-f)'    , 'easymotion-goto-char']       ,
      \ 'F' : ['<Plug>(easymotion-overwin-f2)'   , 'easymotion-goto-char-2']     ,
      \ 'l' : ['<Plug>(easymotion-overwin-line)' , 'jump-linewise']              ,
      \ 'j' : ['<Plug>(easymotion-j)'            , 'jump-line-above']            ,
      \ 'k' : ['<Plug>(easymotion-k)'            , 'jump-line-under']            ,
      \ 'w' : ['<Plug>(easymotion-overwin-w)'    , 'jump-to-word-bidirectional'] ,
      \ 'e' : ['<Plug>(easymotion-prefix)w'      , 'jump-forward-wordwise']      ,
      \ 'b' : ['<Plug>(easymotion-prefix)b'      , 'jump-backword-wordwise']     ,
      \ }
let g:neospace_map['m'] = { 'name' : '+motion' }
let g:neospace_map['p'] = { 'name' : '+projects' }
let g:neospace_map['q'] = [ 'q' , 'quit']
let g:neospace_map['r'] = { 'name' : '+run' }
let g:neospace_map['s'] = { 'name' : '+setting',
      \ 'n' : ['source ~/.neospace' , 'reload-neospace']         ,
      \ 'v' : ['source $MYVIMRC'    , 'reload-vimrc']            ,
      \ }

let g:neospace_map['t'] = { 'name' : '+toggle',
      \ 'a' : ['neospace#util#ToggleHiddenAll()'            , 'HiddenAll']      ,
      \ 'c' : ['neospace#util#ToggleColorColumn()'         , 'CursorColumn']   ,
      \ 'f' : ['NERDTreeToggle'                     , 'NERDTree']       ,
      \ 'g' : ['GitGutterToggle'                    , 'GitGutter']      ,
      \ 'i' : ['IndentLinesToggle'                  , 'IndentLine']     ,
      \ 'p' : ['setlocal paste!'                    , 'paste']          ,
      \ 'r' : ['neospace#util#ToggleCursorColumn()'          , 'RangeColumn']    ,
      \ 't' : ['Vista!!'                            , 'Vista']          ,
      \ }

nnoremap <Plug>(window_w) <C-W>w
nnoremap <Plug>(window_r) <C-W>r
nnoremap <Plug>(window_d) <C-W>c
nnoremap <Plug>(window_q) <C-W>q
nnoremap <Plug>(window_j) <C-W>j
nnoremap <Plug>(window_k) <C-W>k
nnoremap <Plug>(window_h) <C-W>h
nnoremap <Plug>(window_l) <C-W>l
nnoremap <Plug>(window_H) <C-W>5<
nnoremap <Plug>(window_L) <C-W>5>
nnoremap <Plug>(window_J) :resize +5<CR>
nnoremap <Plug>(window_K) :resize -5<CR>
nnoremap <Plug>(window_b) <C-W>=
nnoremap <Plug>(window_s1) <C-W>s
nnoremap <Plug>(window_s2) <C-W>s
nnoremap <Plug>(window_v1) <C-W>v
nnoremap <Plug>(window_v2) <C-W>v
nnoremap <Plug>(window_2) <C-W>v

let g:neospace_map['u'] = { 'name' : '+UI' }
let g:neospace_map['v'] = { 'name' : '+wiki/web' }
let g:neospace_map['w'] = { 'name' : '+windows',
      \ 'w' : ['<Plug>(window_w)'  , 'other-window']          ,
      \ 'd' : ['<Plug>(window_d)'  , 'delete-window']         ,
      \ '-' : ['<Plug>(window_s1)' , 'split-window-below']    ,
      \ '|' : ['<Plug>(window_v1)' , 'split-window-right']    ,
      \ '2' : ['<Plug>(window_v1)' , 'layout-double-columns'] ,
      \ 'h' : ['<Plug>(window_h)'  , 'window-left']           ,
      \ 'j' : ['<Plug>(window_j)'  , 'window-below']          ,
      \ 'l' : ['<Plug>(window_l)'  , 'window-right']          ,
      \ 'k' : ['<Plug>(window_k)'  , 'window-up']             ,
      \ 'H' : ['<Plug>(window_H)'  , 'expand-window-left']    ,
      \ 'J' : ['<Plug>(window_J)'  , 'expand-window-below']   ,
      \ 'L' : ['<Plug>(window_L)'  , 'expand-window-right']   ,
      \ 'K' : ['<Plug>(window_K)'  , 'expand-window-up']      ,
      \ '=' : ['<Plug>(window_b)'  , 'balance-window']        ,
      \ 's' : ['<Plug>(window_s1)' , 'split-window-below']    ,
      \ 'v' : ['<Plug>(window_v1)' , 'split-window-below']    ,
      \ '?' : ['Windows'           , 'fzf-window']            ,
      \ }

let g:neospace_map['x'] = { 'name' : '+text',
      \ 'c' : ['nohlsearch',        'clear search'],
      \ 'd' : ['setlocal ff=dos',   'dos fileformat'],
      \ 'u' : ['setlocal ff=unix',  'unix fileformat'],
      \ 's' : ['StripWhitespace',   'strip eol space'],
      \ 'y' : ['Goyo',              'Goyo-mode'],
      \ }

let g:neospace_map['z'] = { 'name' : '+zsh/fold' ,
      \ '0' : ['set foldlevel=0'    , '0-fold-level']          ,
      \ '1' : ['set foldlevel=1'    , '1-fold-level']          ,
      \ '2' : ['set foldlevel=2'    , '2-fold-level']          ,
      \ '3' : ['set foldlevel=3'    , '3-fold-level']          ,
      \ '4' : ['set foldlevel=4'    , '4-fold-level']          ,
      \ '5' : ['set foldlevel=5'    , '5-fold-level']          ,
      \ '6' : ['set foldlevel=6'    , '6-fold-level']          ,
      \ '7' : ['set foldlevel=7'    , '7-fold-level']          ,
      \ '8' : ['set foldlevel=8'    , '8-fold-level']          ,
      \ '9' : ['set foldlevel=9'    , '9-fold-level']          ,
      \ 'v' : ['vs term://zsh'      , 'zsh at right']          ,
      \ 's' : ['sp term://zsh'      , 'zsh at bottom']         ,
      \ }

function neospace#leader#register(key, options, local)
  if a:local
    let l:map = g:neospace_lmap
  else
    let l:map = g:neospace_map
  end

  let l:c = strlen(a:key) - 1
  if l:c==0
    let l:map[a:key] = a:options
  else
    let l:i = 0
    let l:k = ''
    while l:i < l:c
      let l:k = strcharpart(a:key, l:i, 1)
      let l:map = l:map[l:k]
      let l:i += 1
    endwhile
    let l:k = strcharpart(a:key, l:i, 1)
    let l:map[l:k] = a:options
  end
endfunction

function neospace#leader#active(leader)
  call luaeval("require('neospace.leader').leader(_A)", a:leader)
endfunction
