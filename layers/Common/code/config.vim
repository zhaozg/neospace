xmap <Leader>xf :Neoformat<CR>
nmap <Leader>xf :Neoformat<CR>

xmap <Leader>tS :UltiSnipsEdit<CR>
nmap <Leader>tS :UltiSnipsEdit<CR>

" splitjoin.vim {{{
let g:splitjoin_join_mapping  = ''
let g:splitjoin_split_mapping = ''

nmap <Leader>cJ <plug>SplitjoinJoin
nmap <Leader>cS <Plug>SplitjoinSplit
" }}}

" NERDCommenter { "
vmap <Leader>cZ  <Plug>NERDCommenterAltDelims
vmap <Leader>cU  <Plug>NERDCommenterUncomment
vmap <Leader>cL  <Plug>NERDCommenterAlignLeft
vmap <Leader>cB  <Plug>NERDCommenterAlignBoth
vmap <Leader>cM  <Plug>NERDCommenterMinimal
vmap <Leader>cC  <Plug>NERDCommenterComment
vmap <Leader>c<Space>  <Plug>NERDCommenterToggle
vmap <Leader>cN  <Plug>NERDCommenterNested
vmap <Leader>cI  <Plug>NERDCommenterInvert
vmap <Leader>cA  <Plug>NERDCommenterAppend
vmap <Leader>c$  <Plug>NERDCommenterToEOL
" } NERDCommenter "

nnoremap <SID>Man :Man <C-R><C-W><CR>
nnoremap <Leader>cp :Printf<CR>

nmap<Leader>hm <SID>Man

lua require'colorizer'.setup()

" completion-nvim {{{
if has('nvim-0.5')
autocmd BufEnter * lua require'completion'.on_attach()
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <TAB>
  \ pumvisible() ? "\<C-n>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ completion#trigger_completion()

" change default
let g:completion_enable_snippet = 'UltiSnips'
let g:completion_enable_in_comment = 1
let g:completion_trigger_character = ['.', '::', '->']

"c-n" : i_CTRL-N
"c-p" : i_CTRL-P
"cmd" : i_CTRL-X_CTRL-V
"defs": i_CTRL-X_CTRL-D
"dict": i_CTRL-X_CTRL-K
"file": i_CTRL-X_CTRL-F
"incl": i_CTRL-X_CTRL-I
"keyn": i_CTRL-X_CTRL-N
"keyp": i_CTRL-X_CTRL-P
"line": i_CTRL-X_CTRL-L
"spel": i_CTRL-X_s
"tags": i_CTRL-X_CTRL-]
"thes": i_CTRL-X_CTRL-T
"user": i_CTRL-X_CTRL-U

let g:completion_chain_complete_list = {
            \ 'default' : {
            \   'default': [
            \       {'complete_items': ['lsp', 'snippet', 'ts']},
            \       {'mode': '<c-p>'},
            \       {'mode': '<c-n>'}
            \   ],
            \   'comment': [],
            \   'string' : [
            \       {'complete_items': ['path'], 'triggered_only': ['/']}
            \   ]
            \ },
            \ 'markdown' : {
            \   'default': [
            \       {'mode': 'spel'}
            \   ],
            \   'comment': []
            \   }
            \ }

endif
" }}}

