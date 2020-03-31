" emmet {
let g:user_emmet_mode = 'a'
let g:user_emmet_leader_key='<C-E>'
" }

if executable('tidy')
  let g:neoformat_xml_tidy = {
        \ 'exe': 'tidy',
        \ 'args': ['-quiet',
        \          '-xml',
        \          '-utf8',
        \          '--indent auto',
        \          '--indent-spaces 2',
        \          '--vertical-space yes',
        \          '--tidy-mark no'
        \         ],
        \ 'stdin': 1,
        \ }
  let g:neoformat_xhtml_tidy = {
        \ 'exe': 'tidy',
        \ 'args': ['-quiet',
        \          '-asxhtml',
        \          '-utf8',
        \          '--indent auto',
        \          '--indent-spaces 2',
        \          '--vertical-space yes',
        \          '--tidy-mark no'
        \         ],
        \ 'stdin': 1,
        \ }
  let g:neoformat_enabled_xhtml = ['tidy']
  let g:neoformat_enabled_xml = ['tidy']
endif

if executable('html-beautify')
  let g:neoformat_enabled_xhtml = ['htmlbeautify']
endif
if executable('css-beautify')
  let g:neoformat_enabled_css = ['cssbeautify']
endif
if executable('js-beautify')
  let g:neoformat_enabled_javascript = ['jsbeautify']
endif

augroup fmtxhtml
  autocmd!
  autocmd filetype xml,xhtml setlocal ts=2 sw=2 et tw=79 fen fdm=indent
  autocmd BufWritePre * if &ft == 'css' | undojoin | Neoformat | endif
augroup END

