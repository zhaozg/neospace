return {
  {
    "rest-nvim/rest.nvim",
    after = { "nvim-lua/plenary.nvim" },
    config = function()
      local rest = require('rest-nvim')
      rest.setup({
        result = {
          show_url = true,
          show_curl_command = true,
          show_http_info = true,
          show_headers = true,
        }
      })

      vim.keymap.set('n', '<CR>', rest.run)
    end
  },
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
