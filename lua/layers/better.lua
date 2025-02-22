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
    "folke/snacks.nvim",
    config = function()
      require('snacks').setup({

        bigfile = { enabled = true },
        dashboard = { enabled = false },
        explorer = { enabled = true },
        indent = { enabled = true },
        input = { enabled = true },
        picker = { enabled = true },
        notifier = { enabled = true },
        quickfile = { enabled = true },
        scope = { enabled = true },
        scroll = { enabled = true },
        statuscolumn = { enabled = true },
        words = { enabled = true },
        zen = { enable = true }
      })
    end
  }
}
