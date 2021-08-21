local g = vim.g

return {
  {
    'morhetz/gruvbox',
    init = function()
      -- gruvbox {
      g.gruvbox_bold=1
      g.gruvbox_italic=1
      g.gruvbox_undercurl=1
      g.gruvbox_underline=1
      g.gruvbox_inverse=1
      g.gruvbox_improved_strings=1
      g.gruvbox_improved_warnings=1
      g.gruvbox_termcolors=256
      g.gruvbox_invert_indent_guides=0
      -- }
    end,
    config = function()
      vim.cmd [[colorscheme gruvbox]]
    end
  }
}

