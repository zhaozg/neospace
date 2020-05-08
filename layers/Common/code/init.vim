let g:rainbow_active = 1 "0 if you want to enable it later via :RainbowToggle
let g:rainbow_conf = {
\   'separately': {
\       'cmake': 0,
\   }
\}

" vim_indent_guides { "
let g:indent_guides_enable_on_vim_startup = 0
let g:indent_guides_guide_size = 1
let g:indent_guides_default_mapping = 0
nmap <silent> <Leader>ti <Plug>IndentGuidesToggle
" } vim_indent_guides "

" Not use default NERDcommenter mapping
let g:NERDCreateDefaultMappings = 0

" EditorConfig
let g:editorconfig_blacklist = {
    \ 'filetype': ['git.*', 'fugitive'],
    \ 'pattern': ['\.un~$','scp://.\*']}

" untisnap {
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsUsePythonVersion    = 2
let g:UltiSnipsEditSplit           = 'context'
if exists('g:UltiSnipsSnippetsDir')
  let g:UltiSnipsSnippetDirectories  = [g:UltiSnipsSnippetsDir, 'UltiSnips']
endif

let g:UltiSnipsExpandTrigger       = "<nop>"  "CR will do snips expad, look at package.vim
let g:UltiSnipsJumpForwardTrigger  = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<S-tab>"
" }

" By default auto popup is enable, turn it off by
let g:completion_enable_auto_popup = 0
