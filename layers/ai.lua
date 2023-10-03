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
      "jcdickinson/http.nvim",
      install = { "cargo", "build --workspace --release" }
  },
  {
    -- https://zhuanlan.zhihu.com/p/630213524
    "jcdickinson/codeium.nvim",
    after = {
        "jcdickinson/http.nvim",
        "nvim-lua/plenary.nvim",
        "hrsh7th/nvim-cmp",
    },
    config = function()
        require("codeium").setup({
        })
    end
  }
}
