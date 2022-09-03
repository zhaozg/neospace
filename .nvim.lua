function UserInit()
end

function UserConfig()
  local setting = require('neospace.lsp').setting
  setting('sumneko_lua', { settings = {
    Lua = {
      diagnostics = {
        enable = true,
        globals = {
          'vim',
        }
      }
    }
  } })
end

return {
  init = UserInit,
  config = UserConfig
}
