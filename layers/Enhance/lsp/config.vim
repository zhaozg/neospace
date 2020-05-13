function s:load_lsp(timer)
  if g:neospace.lsp_enable['sh'] && executable('bash-language-server')
    lua require'neospace.lsp'.setup('bashls', {})
  endif

  if g:neospace.lsp_enable['js'] && executable('typescript-language-server')
    lua require'neospace.lsp'.setup('tsserver', {})
  endif

  if g:neospace.lsp_enable['css'] && executable('css-languageserver')
    lua require'neospace.lsp'.setup('cssls', {})
  endif

  if g:neospace.lsp_enable['js'] && executable('vim-language-server')
    lua require'neospace.lsp'.setup('vimls', {})
  endif

  if g:neospace.lsp_enable['c'] && executable('clangd')
    lua require'neospace.lsp'.setup('clangd', {})
  endif

  if g:neospace.lsp_enable['java'] && exists("g:neospace_jdtls") && executable(g:neospace_jdtls)
lua << EOF
  require'neospace.lsp'.setup('jdtls', {
      cmd = {require'nvim'.v["neospace_jdtls"]}
  })
EOF
  endif

  " https://github.com/neovim/nvim-lsp/issues/136#issuecomment-596693910
  if  g:neospace.lsp_enable['lua'] && exists('g:neospace_luals_cmd') &&
        \ exists('g:neospace_luals_main') &&
        \ executable(g:neospace_luals_cmd) && filereadable(g:neospace_luals_main)
lua << EOF
  local nvim = require'nvim'
  local luals_cmd = nvim.g['neospace_luals_cmd']
  local luals_main = nvim.g['neospace_luals_main']
  require'neospace.lsp'.setup('sumneko_lua', {
    cmd = {luals_cmd, luals_main},
    Lua = {
      completion = {
        keywordSnippet = "Disable";
      };
      runtime = {
        version = "LuaJIT";
      };
    };
  })
EOF
  endif
endfunction

call timer_start(500, function('s:load_lsp'))
