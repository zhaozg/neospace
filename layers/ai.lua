return {
  -- "github/copilot.vim"
  {
    "zbirenbaum/copilot.lua",
    on = "Copilot",
    config = function()
      require("copilot").setup({})
    end,
  },
  {
    -- https://zhuanlan.zhihu.com/p/630213524
    "Exafunction/codeium.nvim",
    after = {
        "nvim-lua/plenary.nvim",
        "hrsh7th/nvim-cmp",
    },
    config = function()
        require("codeium").setup({
        })
    end
  }
}
