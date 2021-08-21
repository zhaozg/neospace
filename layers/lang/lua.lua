vim.g.neoformat_lua_luaformatter= {
  exe = 'lua-format'
}

if vim.fn.filereadable(os.getenv('HOME') .. '/.lua-format') then
  vim.g.neoformat_lua_luaformatter= {
    exe = 'lua-format',
    args = {''-c' .. os.getenv('HOME') .. '/.lua-format'}
  }
end
