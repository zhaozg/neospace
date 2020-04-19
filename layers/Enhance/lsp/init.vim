let g:diagnostic_enable_virtual_text = 1
let g:diagnostic_virtual_text_prefix = '⛔'
let g:diagnostic_insert_delay = 1
let g:space_before_virtual_text = 5

let g:neospace.lsp_enable = get(g:, "neospace.lsp_enable", {
  \ 'lua': 1,
  \ 'sh': 1,
  \ 'css': 1,
  \ 'c': 1,
  \ 'js': 1,
  \ 'vim': 1,
  \ 'java': 1
  \ })

