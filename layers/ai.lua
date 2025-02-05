return {
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
  },
  {
    "olimorris/codecompanion.nvim",
    after = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function ()
      require("codecompanion").setup({
        strategies = {
          chat = {
            adapter = "ollama",
          },
          inline = {
            adapter = "ollama",
          },
          agent = {
            adapter = "ollama"
          },
        },
        adapters = {
          -- copilot = function()
          --   return require("codecompanion.adapters").extend("copilot", {
          --     schema = {
          --       model = {
          --         default = "GTP 4o",
          --       },
          --       max_tokens = {
          --         default = 65536,
          --       },
          --     },
          --   })
          -- end,
          ollama = function()
            return require("codecompanion.adapters").extend("ollama", {
              -- name = "deepseek",
              -- schema = {
              --   model = { default = "deepseek-r1:1.5b" },
              -- },
              name = 'qwen',
              schema = {
                model = { default = "qwen2.5-coder:3b" },
              },
            })
          end,
        },
      })
    end
  }
}
