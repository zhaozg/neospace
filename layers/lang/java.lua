return {
  {
    "kamichidu/vim-edit-properties",
    ft = { "jproperties" },
    config = function()
      vim.cmd("%EditPropsDecode")
    end
  },
}
