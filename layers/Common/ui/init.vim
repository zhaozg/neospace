scriptencoding utf-8

" gruvbox {
let g:gruvbox_termcolors         = '256'
let g:gruvbox_italic             = '1'
let g:gruvbox_italicize_comments = '1'
let g:gruvbox_improved_strings   = '1'
" }

" vim-airline {
let g:Powerline_symbols                                 = 'fancy'
let g:airline_powerline_fonts                           = 1
let g:airline#extensions#branch#enabled                 = 1
let g:airline#extensions#tabline#enabled                = 1
let g:airline#extensions#tabline#buffer_idx_mode        = 1
let g:airline#extensions#tabline#buffer_nr_show         = 1
let g:airline#extensions#tabline#buffer_nr_format       = '%s:'
let g:airline#extensions#tabline#fnamemod               = ':t'
let g:airline#extensions#tabline#fnamecollapse          = 1
let g:airline#extensions#tabline#fnametruncate          = 0
let g:airline#extensions#tabline#formatter              = 'unique_tail_improved'
let g:airline#extensions#default#section_truncate_width = {
      \ 'b': 79,
      \ 'x': 60,
      \ 'y': 88,
      \ 'z': 45,
      \ 'warning': 80,
      \ 'error': 80,
      \ }
"let g:airline#extensions#default#layout                 = [
"\ [ 'a', 'error', 'warning', 'b', 'c' ],
"\ [ 'x', 'y', 'z' ]
"\ ]
" Distinct background color is enough to discriminate the warning and
" error information.
let g:airline#extensions#ale#error_symbol               = '•'
let g:airline#extensions#ale#warning_symbol             = '•'

if !exists('g:airline_powerline_fonts')
  let g:airline_left_sep=''
  let g:airline_right_sep=''
  let g:airline_symbols = {
        \'crypt'      = '🔒',
        \'linenr'     = '␊',
        \'branch'     = '⎇',
        \'paste'      = 'Þ',
        \'whitespace' = 'Ξ',
  }
endif
" }

" Nerdtree {{
let g:NERDTreeDirArrowExpandable  = "▸"
let g:NERDTreeDirArrowCollapsible = "▾"
let g:NERDTreeNodeDelimiter       = "\u00a0"

let g:NERDTreeShowIgnoredStatus   = 0
let g:NERDTreeShowHidden          = 0
let g:NERDTreeAutoDeleteBuffer    = 1

" vim-nerdtree-syntax-highlight {
let g:NERDTreeFileExtensionHighlightFullName = 1
let g:NERDTreeExactMatchHighlightFullName    = 1
let g:NERDTreePatternMatchHighlightFullName  = 1
let g:NERDTreeLimitedSyntax                  = 1
" }
" }}

" devicons { "

" specify OS to decide an icon for unix fileformat (not defined by default)
" this is useful for avoiding unnecessary system() call. see #135 for further details.
if g:neospace.os.mac
  let g:WebDevIconsOS = 'Darwin'
end

let g:DevIconsAppendArtifactFix = 0
let g:DevIconsArtifactFixChar = ''

" use double-width(1) or single-width(0) glyphs
" only manipulates padding, has no effect on terminal or set(guifont) font
let g:WebDevIconsUnicodeGlyphDoubleWidth = 1

" whether or not to show the nerdtree brackets around flags
let g:webdevicons_conceal_nerdtree_brackets = 0

" the amount of space to use before the glyph character (default ' ')
let g:WebDevIconsNerdTreeBeforeGlyphPadding = ''

" the amount of space to use after the glyph character (default ' ')
let g:WebDevIconsNerdTreeAfterGlyphPadding = ''

" Force extra padding in NERDTree so that the filetype icons line up vertically
let g:WebDevIconsNerdTreeGitPluginForceVAlign = 1

" enable folder/directory glyph flag (disabled by default with 0)
let g:WebDevIconsUnicodeDecorateFolderNodes = 1

" enable open and close folder/directory glyph flags (disabled by default with 0)
let g:DevIconsEnableFoldersOpenClose = 1

" enable file extension pattern matching glyphs on folder/directory (disabled by default with 0)
let g:DevIconsEnableFolderExtensionPatternMatching = 1

" } devicons "

" { vista
let g:vista_icon_indent = ['└▸ ', '├▸ ']
let g:vista_echo_cursor_strategy = 'scroll'
" To enable fzf's preview window set g:vista_fzf_preview.
" The elements of g:vista_fzf_preview will be passed as arguments to fzf#vim#with_preview()
" For example:
let g:vista_fzf_preview = ['right:50%']
" Ensure you have installed some decent font to show these pretty symbols, then you can enable icon for the kind.
let g:vista#renderer#enable_icon = 1

let g:vista_executive_for = {
    \ 'vimwiki': 'markdown',
    \ 'pandoc': 'markdown',
    \ 'markdown': 'toc',
    \ }
" } vista

" startify {{{
function! s:get_nvim_version()
  redir => l:s
  silent! version
  redir END
  return matchstr(l:s, 'NVIM v\zs[^\n]*')
endfunction
let s:version = g:neospace.nvim ? 'nvim '.s:get_nvim_version() : 'vim '.v:version

let s:list_order = [
            \ ['   Project:'],
            \ 'dir',
            \ ['   Recent Files:'],
            \ 'files',
            \ ['   Sessions:'],
            \ 'sessions',
            \ ['   Bookmarks:'],
            \ 'bookmarks',
            \ ['   Commands:'],
            \ 'commands',
            \ ]
let g:startify_list_order = s:list_order
let g:startify_change_to_vcs_root = 1
let g:startify_session_autoload = 1
let g:startify_change_to_dir = 1

function! s:filter_header(lines) abort
  let longest_line   = max(map(copy(a:lines), 'strwidth(v:val)'))
  let centered_lines = map(copy(a:lines),
        \ 'repeat(" ", (&columns / 2) - (longest_line / 2)) . v:val')
  return centered_lines
endfunction

let s:custom_header = [
      \' _        _______  _______  _______  _______  _______  _______  _______',
      \'( (    /|(  ____ \(  ___  )(  ____ \(  ____ )(  ___  )(  ____ \(  ____ \',
      \'|  \  ( || (    \/| (   ) || (    \/| (    )|| (   ) || (    \/| (    \/',
      \'|   \ | || (__    | |   | || (_____ | (____)|| (___) || |      | (__',
      \'| (\ \) ||  __)   | |   | |(_____  )|  _____)|  ___  || |      |  __)',
      \'| | \   || (      | |   | |      ) || (      | (   ) || |      | (',
      \'| )  \  || (____/\| (___) |/\____) || )      | )   ( || (____/\| (____/\',
      \'|/    )_)(_______/(_______)\_______)|/       |/     \|(_______/(_______/',
      \'             [ neospace ' . g:neospace.version . ' ＠' . s:version . ' ]',
      \]
let g:startify_custom_header = s:filter_header(s:custom_header)
" }}}

