let g:vimwiki_md2html = get(g:, 'vimwiki_md2html', '')
let g:vimwiki_md2html_args = get(g:, 'vimwiki_md2html_args', [])

let g:vimwiki_list = [{
      \ 'path':                  '~/Documents/Notes',
      \ 'path_html':             '~/Documents/Notes_html',
      \ 'syntax':                'markdown',
      \ 'ext':                   '.md',
      \ 'custom_wiki2html':      g:vimwiki_md2html,
      \ }]

"let g:vimwiki_ext2syntax = {
      "\ '.md':                   'markdown',
      "\ '.mkd':                  'markdown',
      "\ '.wiki':                 'media',
      "\ '.dot':                  'dot'
      "\ }

let g:vimwiki_global_ext=0
let g:vimwiki_map_prefix = '<Leader>v'

