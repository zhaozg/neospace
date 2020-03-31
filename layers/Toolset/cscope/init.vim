let s:modules = []

if executable('gtags-cscope') && executable('gtags')
  let s:modules += ['gtags_cscope']
else
  let s:modules += ['ctags']
endif
let s:vim_tags = expand('~/.cache/tags')
" create if ~/.cache/tags does not exist
if !isdirectory(s:vim_tags)
   silent! call mkdir(s:vim_tags, 'p')
endif

" let g:gutentags_ctags_tagfile = '.tags'
" set default tags file name `tags` to `.tags`
" set tags=./.tags;,.tags

let g:gutentags_project_root = ['.root']
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']

let g:gutentags_modules = s:modules

" Specifies a directory in which to create all the tags files
let g:gutentags_cache_dir = s:vim_tags

" ERROR: gutentags: gtags-cscope job failed, returned: 1
let g:gutentags_define_advanced_commands = 1

" Not use define GscopeFind bind
let g:gutentags_plus_nomap = 1
