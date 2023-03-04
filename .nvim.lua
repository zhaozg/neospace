function UserInit()
end

function UserConfig()
  local setting = require("neospace.lsp").setting
  local lsp = require("lspconfig")
  local options = setting("lua_ls", {
    settings = {
      Lua = {
        runtime = {
          version = "LuaJIT",
        },
        diagnostics = {
          globals = { "vim" },
        },
        format = {
          format = false,
        },
      },
    },
  })
  lsp.lua_ls.setup(options)

  local null_ls = require("null-ls")
  null_ls.setup(setting("null-ls", {
    sources = {
      null_ls.builtins.formatting.stylua,
    },
  }))
end

return {
  init = UserInit,
  config = UserConfig,
}
