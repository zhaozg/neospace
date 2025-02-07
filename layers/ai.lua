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
        display = {
          action_palette = {
            width = 95,
            height = 10,
            prompt = "Prompt ", -- Prompt used for interactive LLM calls
            provider = "telescope", -- default|telescope|mini_pick
            opts = {
              -- Show the default actions in the action palette?
              show_default_actions = true,
              -- Show the default prompt library in the action palette?
              show_default_prompt_library = true,
            },
          },
        },
        opts = {
          log_level = "DEBUG",
        },
        strategies = {
          chat = { adapter = "copilot", },
          inline = { adapter = "copilot", },
          agent = { adapter = "copilot" },
        },
        adapters = {
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
