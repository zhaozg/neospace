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
  {
    "itchyny/calendar.vim",
    on = "Calendar",
    init = function()
      vim.g.calendar_week_number = 1
    end
  }
}
