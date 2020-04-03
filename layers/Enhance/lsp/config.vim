function s:load_lsp(timer)
  if executable('bash-language-server')
    lua require'neospace.lsp'.setup('bashls', {})
  endif

  if executable('typescript-language-server')
    lua require'neospace.lsp'.setup('tsserver', {})
  endif

  if executable('css-languageserver')
    lua require'neospace.lsp'.setup('cssls', {})
  endif

  if executable('vim-language-server')
    lua require'neospace.lsp'.setup('vimls', {})
  endif

  if executable('clangd')
    lua require'neospace.lsp'.setup('clangd', {})
  endif

  if exists("g:neospace_jdtls") && executable(g:neospace_jdtls)
lua << EOF
  require'neospace.lsp'.setup('jdtls', {
      cmd = {require'nvim'.v["neospace_jdtls"]}
  })
EOF
  endif

  " https://github.com/neovim/nvim-lsp/issues/136#issuecomment-596693910
  if exists('g:neospace_luals_cmd') && exists('g:neospace_luals_main') &&
        \ executable(g:neospace_luals_cmd ) && filereadable(g:neospace_luals_main)
lua << EOF
  local nvim = require'nvim'
  local luals_cmd = nvim.v['neospace_luals_cmd']
  local luals_main = nvim.v['neospace_luals_main']
  require'neospace.lsp'.setup('sumneko_lua', {
    cmd = {luals_cmd, luals_main}
  })
EOF
  endif
endfunction

call timer_start(500, function('s:load_lsp'))
