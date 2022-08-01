vim.cmd([[
augroup plgmaven
  autocmd!
  autocmd filetype java setlocal ts=2 sw=2 et tw=79 fen fdm=marker
augroup END
]])

return {
  {
    "kamichidu/vim-edit-properties",
    ["for"] = { "jproperties" },
  },
}
