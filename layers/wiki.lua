local vim = vim
local g = vim.g

return {
  {
    'vimwiki/vimwiki',
    opt = true,
    cmd = {},
    init = function()
      g.vimwiki_md2html = vim.fn.get('g:', 'vimwiki_md2html', '')
      g.vimwiki_md2html_args = vim.fn.get('g:', 'vimwiki_md2html_args', {})

      vim.g.vimwiki_list = {{
      path=              '~/Documents/Notes',
      path_html=         '~/Documents/Notes_html',
      syntax=            'markdown',
      ext=               '.md',
      custom_wiki2html=  vim.g.vimwiki_md2html,
      }}

      g.vimwiki_global_ext = 0
      g.vimwiki_map_prefix = '<leader>v'
    end,
    config = function()
    end
  }
}
