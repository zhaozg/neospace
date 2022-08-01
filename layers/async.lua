local g = vim.g

return {
  {
    "skywind3000/asyncrun.vim",
    init = function()
      g.asyncrun_status = "stopped"
      g.asyncrun_open = 6
      g.asyncrun_rootmarks = { "pom.xml", ".git", ".svn", ".root", ".project", ".hg" }
    end,
  },
  {
    "skywind3000/asynctasks.vim",
    init = function()
      g.asynctasks_extra_config = {
        "~/.config/asynctask/tasks.ini",
      }
    end,
  },
}
