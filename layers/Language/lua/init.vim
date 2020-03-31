let g:neoformat_lua_luaformatter= {
  \ 'exe': 'lua-format'
  \ }

if filereadable ($HOME . '/.lua-format')
  let g:neoformat_lua_luaformatter= {
    \ 'exe': 'lua-format',
    \ 'args': ['-c'. $HOME . '/.lua-format']
    \ }
endif

