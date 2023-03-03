function UserInit()
end

function UserConfig()
  local setting = require("neospace.lsp").setting
  local lsp = require "lspconfig"
  local options = setting("lua_ls", {
    settings = {
      Lua = {
        diagnostics = {
          globals = { "vim" }
        }
      }
    }
  })
  lsp.lua_ls.setup(options)
end

return {
  init = UserInit,
  config = UserConfig
}
