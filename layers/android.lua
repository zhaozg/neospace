return {
  {
    "hsanson/vim-android",
    on = { "Android", "Gradle" },
    init = function()
      vim.g.gradle_glyph_error = ""
      vim.g.gradle_glyph_warning = ""
      vim.g.gradle_glyph_gradle = ""
      vim.g.gradle_glyph_android = ""
      vim.g.gradle_glyph_building = ""
      vim.g.gradle_daemon = 1
      vim.g.gradle_quickfix_show = 1
    end,
    config = function()
      vim.cmd("call android#setupAndroidCommands()")
      vim.cmd("call gradle#setupGradleCommands()")
    end
  },
}
