if neospace#has#plugin('airline')
  autocmd filetype markdown,vimwiki let g:airline#extensions#wordcount#formatter = 'cnfmt'
endif
