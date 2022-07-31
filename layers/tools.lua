return {
  {
    'blindFS/vim-taskwarrior',
    cmd ='TW',
    config = function()
      vim.cmd[[
augroup taskwarrior
  autocmd!
  autocmd filetype taskedit DisableWhitespace
augroup END
      ]]
    end
  },
  {
    'itchyny/calendar.vim',
    opt = true,
    enable = false,
    cmd = { 'Calendar' }
  }
}

