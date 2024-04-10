return {
  {
    "zhaozg/taskwarrior.nvim",
    on = "Task",
    after = "nvim-telescope/telescope.nvim",
    config = function()
      require("taskwarrior_nvim").setup({
      })
    end,
  },
}
