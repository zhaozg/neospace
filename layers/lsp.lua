return {
  {
    'neovim/nvim-lspconfig',
    opt = ture,

  },
  {
    'nvim-lua/lsp-status.nvim',
    opt = ture
  },
  {
    'ojroques/nvim-lspfuzzy',
    opt = ture,
    config = function()
      require('lspfuzzy').setup {}
    end
  }
}
