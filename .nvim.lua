function UserInit()
end

function UserConfig()
  local setting = require('neospace.lsp').setting
  setting('lua_ls', { settings = {
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
