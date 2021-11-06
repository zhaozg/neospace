lua << EOF
  local vim = vim
  local setting = require'neospace.lsp'.setting
  setting('sumneko_lua', { settings = {
    Lua = {
      diagnostics = {
        enable = true,
        globals = {
          'vim',
        }
      }
    }
  }})
EOF
