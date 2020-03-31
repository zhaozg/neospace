let g:rainbow_active = 1 "0 if you want to enable it later via :RainbowToggle

" indentLine {
" ¦, ┆, │, ⎸, or ▏
let g:indentLine_char                     = '│'
let g:indentLine_enabled                  = 1
let g:indentLine_concealcursor            = 'vc'      " default 'inc'
let g:indentLine_fileTypeExclude          = ['help', 'startify', 'vimfiler', 'qf', 'nerdtree', 'calendar']
" }

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
let g:UltiSnipsSnippetsDir         = $HOME.'/Private/config/ultisnips'
if exists('g:UltiSnipsSnippetsDir')
let g:UltiSnipsSnippetDirectories  = [g:UltiSnipsSnippetsDir, 'UltiSnips']
endif

let g:UltiSnipsExpandTrigger       = "<nop>"  "CR will do snips expad, look at package.vim
let g:UltiSnipsJumpForwardTrigger  = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<S-tab>"
" }

