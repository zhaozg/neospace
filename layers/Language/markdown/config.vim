if executable('prettier')
  let g:neoformat_enabled_markdown= ['prettier']
  let g:neoformat_enabled_vimnote= ['prettier']
endif

" example
augroup fmtmarkdown
  autocmd!
  autocmd filetype markdown,vimwiki nmap <buffer> <localleader>p <Plug>MarkdownPreview
  autocmd filetype markdown,vimwiki nmap <buffer> <localleader>s <Plug>MarkdownPreviewStop
  autocmd filetype markdown,vimwiki nmap <buffer> <localleader>t <Plug>MarkdownPreviewToggle
  autocmd filetype markdown,vimwiki nmap <buffer> <localleader>f :TableFormat<CR>
augroup END
