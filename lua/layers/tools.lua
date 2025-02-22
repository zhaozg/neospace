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
}
