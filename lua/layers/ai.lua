return {
  {
    -- https://zhuanlan.zhihu.com/p/630213524
    "Exafunction/codeium.nvim",
    dependencies = {
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
    dependencies = {
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
            local name = os.getenv("OLLAMA_NVIM_NAME") or "qwen"
            local model = os.getenv("OLLAMA_NVIM_MODEL") or "qwen2.5-coder:3b"

            return require("codecompanion.adapters").extend("ollama", {
              name = name,
              schema = {
                model = { default = model },
              },
            })
          end,
        },
      })
    end
  }
}
