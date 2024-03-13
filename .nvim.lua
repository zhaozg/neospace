
--- do UserInit in neospace, before any layers or modules laod
function UserInit()
end

--- do UserConfig in neospace, after all layers and modules load
function UserConfig()
  local setting = require("neospace.lsp").setting

  local null_ls = require("null-ls")
  null_ls.setup(setting("null-ls", {
    sources = {
      require("none-ls.diagnostics.luacheck"),
      null_ls.builtins.formatting.stylua,
    },
  }))
end

return {
  init = UserInit,
  config = UserConfig,
}
