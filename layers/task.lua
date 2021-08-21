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
  }
}

