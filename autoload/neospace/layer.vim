let s:neospace_tab = get(s:, 'neospace_tab', -1)
let s:neospace_buf = get(s:, 'neospace_buf', -1)

function s:new_window()
  execute get(g:, 'neospace_window', 'vertical topleft new')
endfunction

function s:neospace_window_exists()
  let l:buflist = tabpagebuflist(s:neospace_tab)
  return !empty(l:buflist) && index(l:buflist, s:neospace_buf) >= 0
endfunction

function s:assign_name()
  " Assign buffer name
  let l:prefix = '[Layers]'
  let l:name   = l:prefix
  let l:idx    = 2
  while bufexists(l:name)
    let l:name = printf('%s (%s)', l:prefix, l:idx)
    let l:idx = l:idx + 1
  endwhile
  silent! execute 'f' fnameescape(l:name)
endfunction

" Extracted from plug.vim
function neospace#layer#status()
  call s:new_window()

  let b:neospace_preview = -1
  let s:neospace_tab = tabpagenr()
  let s:neospace_buf = winbufnr(0)
  call s:assign_name()

  let [l:cnt, l:total] = [0, len(g:neospace.loaded)]

  let g:layers_sum = len(g:neospace)

  call append(0, ['Enabled layers: ' . '(' . len(g:neospace.loaded) . '/' . g:layers_sum . ')'])
  call setline(2, '[' . repeat('=', len(g:neospace.loaded)) . ']')
  let l:inx = 3
  for l:layer in g:neospace.loaded
    call setline(l:inx, '+ ' . l:layer)
    let l:inx = l:inx + 1
  endfor
  setlocal buftype=nofile bufhidden=wipe nobuflisted nolist noswapfile nowrap cursorline nomodifiable nospell
  setf neospace
  if exists('g:syntax_on')
    call s:syntax()
  endif
  nnoremap <silent> <buffer> q  :bd<CR>
endfunction

function s:syntax()
  syntax clear
  syntax region Layer1 start=/\%1l/ end=/\%2l/ contains=LayerNumber
  syntax region Layer2 start=/\%2l/ end=/\%3l/ contains=LayerBracket,LayerX
  syn match LayerNumber /[0-9]\+[0-9.]*/ contained
  syn match LayerBracket /[[\]]/ contained
  syn match LayerX /x/ contained
  syn match LayerDash /^-/
  syn match LayerPlus /^+/
  syn match LayerStar /^*/
  syn match LayerMessage /\(^- \)\@<=.*/
  syn match LayerName /\(^- \)\@<=[^ ]*:/
  syn match LayerInstall /\(^+ \)\@<=[^:]*/
  syn match LayerCache /\(^* \)\@<=[^:]*/
  syn match LayerNotLoaded /(not loaded)$/
  syn match LayerError /^x.*/
  syn region LayerDeleted start=/^\~ .*/ end=/^\ze\S/
  syn match LayerH2 /^.*:\n-\+$/
  syn keyword Function LayerInstall LayerStatus LayerCache LayerClean
  hi def link Layer1       Title
  hi def link Layer2       Repeat
  hi def link LayerH2      Type
  hi def link LayerX       Exception
  hi def link LayerBracket Structure
  hi def link LayerNumber  Number

  hi def link LayerDash    Special
  hi def link LayerPlus    Constant
  hi def link LayerStar    Boolean

  hi def link LayerMessage Function
  hi def link LayerName    Label
  hi def link LayerInstall Function
  hi def link LayerCache   Type

  hi def link LayerError   Error
  hi def link LayerDeleted Ignore

  hi def link LayerNotLoaded Comment
endfunction
