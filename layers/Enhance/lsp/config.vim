function! LspStatus() abort
  let status = luaeval('require("lsp-status").status()')
  return trim(status)
endfunction

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

  if g:neospace.lsp_enable['vim'] && executable('vim-language-server')
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
  local lsp = require'neospace.lsp'
  local globals
  if lsp.lua and lsp.lua.globals then
    globals = lsp.lua.globals
  end
  lsp.setup('sumneko_lua', {
    cmd = {luals_cmd, luals_main},
    settings = {
      Lua = {
        completion = {
          keywordSnippet = "Disable";
        };
        runtime = {
          version = "LuaJIT";
          };
        diagnostics = {
          enable = true,
          globals = globals
        },
        workspace = {
          maxPreload = 0,
          preloadFileSize = 0
        }
      },
    }
  })

  local lsp_status = require('lsp-status')
  lsp_status.register_progress()
  local kind_labels_mt = {__index = function(_, k) return k end}
  local kind_labels = {}
  lsp_status.config({
    kind_labels = kind_labels,
    indicator_errors = "?",
    indicator_warnings = "!",
    indicator_info = "i",
    indicator_hint = "?",
    -- the default is a wide codepoint which breaks absolute and relative
    -- line counts if placed before airline's Z section
    status_symbol = "",
    kind_labels
  })
EOF
  endif

  call airline#parts#define_function('lsp_status', 'LspStatus')
  call airline#parts#define_condition('lsp_status', 'luaeval("#vim.lsp.buf_get_clients() > 0")')

  let g:airline#extensions#nvimlsp#enabled = 1
  let g:airline_section_warning = airline#section#create_right(['lsp_status'])
endfunction

call timer_start(500, function('s:load_lsp'))
