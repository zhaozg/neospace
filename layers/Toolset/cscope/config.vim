if get(g:, 'gutentags_plus_nomap', 0) == 1
  noremap <Plug>FindSymbol     :GscopeFind s <C-R><C-W><cr>
  noremap <Plug>FindDefinition :GscopeFind g <C-R><C-W><cr>
  noremap <Plug>FindCalling    :GscopeFind c <C-R><C-W><cr>
  noremap <Plug>FindText       :GscopeFind t <C-R><C-W><cr>
  noremap <Plug>FindEgrep      :GscopeFind e <C-R><C-W><cr>
  noremap <Plug>FindFile       :GscopeFind f <C-R>=expand("<cfile>")<cr><cr>
  noremap <Plug>FindInclude    :GscopeFind i <C-R>=expand("<cfile>")<cr><cr>
  noremap <Plug>FindCall       :GscopeFind d <C-R><C-W><cr>
  noremap <Plug>FindAssign     :GscopeFind a <C-R><C-W><cr>

  nmap <leader>cs <Plug>FindSymbol
  nmap <leader>cg <Plug>FindDefinition
  nmap <leader>cc <Plug>FindCalling
  nmap <leader>ct <Plug>FindText
  nmap <leader>ce <Plug>FindEgrep
  nmap <leader>cf <Plug>FindFile
  nmap <leader>ci <Plug>FindInclude
  nmap <leader>cd <Plug>FindCall
  nmap <leader>ca <Plug>FindAssign
endif

