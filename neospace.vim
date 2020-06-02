" Let Vim and NeoVim shares the same plugin directory.

let s:neospace_layers_basic     = [ 'async', 'better' ]
let s:neospace_layers_common    = [ 'code', 'text', 'themes', 'ui' ]
let s:neospace_layers_enhance   = [
  \ 'ale',
  \ 'chinese',
  \ 'finder',
  \ 'git',
  \ 'github',
  \ 'treesitter'
  \ ]
let s:neospace_layers_toolset   = [
  \ 'calendar',
  \ 'cscope',
  \ 'debug',
  \ 'nvim',
  \ 'wiki',
  \ 'task'
  \ ]
let s:neospace_layers_languages = [
  \ 'c',
  \ 'diagram',
  \ 'java',
  \ 'lua',
  \ 'markdown',
  \ 'objc',
  \ 'xhtml'
  \ ]
let s:neospace_layers_ultimate  = [ 'xcode' ]

if has('nvim-0.5')
  call add(s:neospace_layers_enhance, 'lsp')
endif

let g:neospace_layers = s:neospace_layers_basic
                    \ + s:neospace_layers_common
                    \ + s:neospace_layers_enhance
                    \ + s:neospace_layers_languages
                    \ + s:neospace_layers_toolset
                    \ + s:neospace_layers_ultimate

" Enable the existing layers in neospace

" Manage your own plugins, refer to vim-plug's instruction for more detials.
function UserInit()
  if filereadable($HOME . "/.config/neospace/init.vim")
    source ~/.config/neospace/init.vim
  endif
endfunction

" Override the default settings as well as adding extras
function UserConfig()
  " Use gui colors in terminal if available
  function! s:enable_termgui()
    if has('termguicolors')
      set termguicolors
      if g:neospace.tmux
        " If use vim inside tmux, see https://github.com/vim/vim/issues/993
        " set Vim-specific sequences for RGB colors
        let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
        let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
      endif
    endif
  endfunction

  call s:enable_termgui()

  if filereadable($HOME . "/.config/neospace/config.vim")
    source ~/.config/neospace/config.vim
  endif
endfunction

" vim: set ts=2 sw=2 et tw=79 fen fdm=marker ft=vim : "
