return {
  "tpope/vim-repeat",
  "tpope/vim-sensible",
  "zhaozg/nvim-defaults",
  "kevinhwang91/promise-async",

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
    "gregorias/nvim-mapper",
    config = function()
      require"nvim-mapper".setup({})
    end,
    before = "nvim-telescope/telescope.nvim"
  }
}
