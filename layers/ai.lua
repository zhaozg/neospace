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
              name = "deepseek",
              schema = {
                model = { default = "deepseek-r1" },
                -- model = { default = "deepseek-coder", },
              },
              -- name = 'codellama',
              -- schema = {
              --   model = { default = "codellama" },
              -- },
            })
          end,
        },
      })
    end
  }
}
