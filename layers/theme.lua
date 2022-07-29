return {
  {
    'ellisonleao/gruvbox.nvim',
    config = function()
      require("gruvbox").setup()

      vim.cmd [[colorscheme gruvbox]]
    end
  }
}

