return {
  "tpope/vim-repeat",
  "tpope/vim-sensible",
  "tpope/vim-sleuth",
  "zhaozg/nvim-defaults",
  "kevinhwang91/promise-async",
  "nathom/filetype.nvim",

  { "nvim-lua/popup.nvim", opt = true },
  { "nvim-lua/neovim-ui", opt = true },
  { "nvim-lua/plenary.nvim", opt = true },
  {
    "rcarriga/nvim-notify",
    config = function()
      vim.notify = require("notify")
    end,
  },
  {
    "pteroctopus/faster.nvim",
    config = function()
      require('faster').setup()
    end
  },
}
