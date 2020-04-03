scriptencoding utf-8

" fzf.vim {
let $LANG = 'en_US'

let $FZF_DEFAULT_OPTS = '--layout=reverse'

let g:fzf_layout = { 'window': 'call OpenFloatingWin()' }
function! OpenFloatingWin()
  let height = &lines - 3
  let width = float2nr(&columns - (&columns * 2 / 10))
  let col = float2nr((&columns - width) / 2)

  let opts = {
        \ 'relative': 'editor',
        \ 'row': height * 0.3,
        \ 'col': col,
        \ 'width': width,
        \ 'height': height * 2 / 3
        \ }

  let buf = nvim_create_buf(v:false, v:true)
  let win = nvim_open_win(buf, v:true, opts)

  call setwinvar(win, '&winhl', 'Normal:Pmenu')

  setlocal
        \ buftype=nofile
        \ nobuflisted
        \ bufhidden=hide
        \ nonumber
        \ norelativenumber
        \ signcolumn=no
endfunction

nmap <Leader>? <plug>(fzf-maps-n)
xmap <Leader>? <plug>(fzf-maps-x)
omap <Leader>? <plug>(fzf-maps-o)

nnoremap <Leader>b? :Buffers<CR>
nnoremap <Leader>w? :Windows<CR>
nnoremap <Leader>f? :Files<CR>

noremap <Plug>(file-in-project) :call neospace#plug#fzf#FindFileInProject()<CR>
noremap <Plug>(in-project) :call neospace#plug#fzf#SearchInProject()<CR>
noremap <Plug>(word-in-project) :call neospace#plug#fzf#SearchCword()<CR>
noremap <Plug>(word-in-buffer)  :call neospace#plug#fzf#SearchBcword()<CR>
"neospace#plug#fzf#Jumps(...)
"
noremap <SID>(Sessions):  call neospace#plug#fzf#Session()<CR>
noremap <SID>(OpenFiles): call neospace#plug#fzf#Open()<CR>
noremap <SID>(Rtp):       call neospace#plug#fzf#Rtp()<CR>
noremap <SID>(Oldfiles):  call neospace#plug#fzf#Oldfiles()<CR>
noremap <SID>(Cmd):       call neospace#plug#fzf#FZFCmd()<CR>
noremap <SID>(Func):      call neospace#plug#fzf#Func()<CR>


""map <Leader>fF <Plug>(file-in-project)
""map <Leader>fw <Plug>(word-in-buffer)
""map <Leader>fW <Plug>(word-in-project)
""map <Leader>fS <SID>(Sessions)
""map <Leader>fO <SID>(OpenFiles)
""map <Leader>fR <SID>(Rtp)
""map <Leader>fC <SID>(Cmd)
""map <Leader>fF <SID>(Func)

call neospace#leader#register('f/', ['BLines'       , 'in-buffer'], 0)
call neospace#leader#register('fb', ['BCommits'     , 'in-BCommits'], 0)
call neospace#leader#register('fc', ['Commits'      , 'in-Commits'], 0)
call neospace#leader#register('fd', ['NERDTreeFind' , 'in-NERDTree'],0)
call neospace#leader#register('ff', ['Files ~'      , 'in-$HOME'], 0)
call neospace#leader#register('f?', ['Files'        , 'in-CWD'],0)
call neospace#leader#register('ft', ['Btags'        , 'in-tags'],0)
call neospace#leader#register('fm', ['Marks'        , 'in-Marks'],0)
call neospace#leader#register('fs', ['Snippets'     , 'in-Snippets'],0)
call neospace#leader#register('fz', ['History'      , 'History'],0)
call neospace#leader#register('fv', ['GFiles'       , 'gitFiles'],0)
call neospace#leader#register('f ', ['Lines'        , 'in-buffer'], 0)
call neospace#leader#register('f:', ['History:'     , 'in-command'], 0)

call neospace#leader#register('fA', ['Ag'           , 'Ag'],0)
call neospace#leader#register('fB', ['Buffers'      , 'Buffers'], 0)
call neospace#leader#register('fF', ['Filetypes'    , 'Filetypes'],0)
call neospace#leader#register('fH', ['Helptags'     , 'Helptags'],0)
call neospace#leader#register('fL', ['Locate'       , 'Locate'],0)
call neospace#leader#register('fM', ['Maps'         , 'Maps'],0)
call neospace#leader#register('fW', ['Windows'      , 'Windows'],0)
call neospace#leader#register('fR', ['Rg'           , 'Rg'],0)
call neospace#leader#register('fS', ['GFiles?'      , 'gitStatus'],0)
call neospace#leader#register('fT', ['tags'         , 'in-tags'],0)
call neospace#leader#register('fZ', ['History/'     , 'Search'],0)

" leader->setting->Colors
call neospace#leader#register('sc', ['Colors'       , 'ColorSchema'], 0)

call neospace#leader#register('f',  {'name':          'finder'}, 1)
call neospace#leader#register('ff', ['Findr'        , 'FindrFile'], 1)
call neospace#leader#register('fb', ['FindrBuffers' , 'FindrBuffers'], 1)
call neospace#leader#register('fl', ['FindrLocList' , 'FindrLocList'], 1)
call neospace#leader#register('fq', ['FindrQFList'  , 'FindrQFList'], 1)

" }
