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
  },
  {
    "LunarVim/bigfile.nvim",
    config = function()
      require("bigfile").setup({
        filesize = 1,

        pattern = {"*"},
        --[[
        pattern = function(bufnr, filesize_mib)
          local file_contents = vim.fn.readfile(vim.api.nvim_buf_get_name(bufnr))
          local file_length = #file_contents
          if file_length > 4000 or filesize_mib > 1 then
            return true
          end
        end,
        --]]

        features = {
          "indent_blankline",
          "treesitter",
          "matchparen",
          "vimopts",
          "lsp",
          "syntax",
          "matchparen",
          "filetype"
        },
      })
    end
  }
}
