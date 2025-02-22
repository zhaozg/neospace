return {
  {
    "zhaozg/taskwarrior.nvim",
    on = "Task",
    dependencies = "nvim-telescope/telescope.nvim",
    config = function()
      require("taskwarrior_nvim").setup({
      })
    end,
  },
  {
    "rest-nvim/rest.nvim",
    enabled = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "rest-nvim/tree-sitter-http"
    },
  }
}
