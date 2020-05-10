scriptencoding utf-8

let g:neospace.info         = g:neospace.base . '/spaces/info.vim'
let g:neospace.plug         = g:neospace.base . '/autoload/plug.vim'
let g:neospace.layers_base  = g:neospace.base . '/layers'
let g:neospace.private_base = g:neospace.base . '/private'
let g:neospace.nvim         = has('nvim') && exists('*jobwait')
let g:neospace.vim8         = exists('*job_start')
let g:neospace.timer        = exists('*timer_start')
let g:neospace.gui          = has('gui_running')
let g:neospace.tmux         = !empty($TMUX)

let g:neospace.defer_long   = 800
let g:neospace.defer_normal = 400
let g:neospace.defer_short  = 200
let g:neospace.defer_now    = 100

let g:neospace.loaded   = []
let g:neospace.excluded = []
let g:neospace.plugins  = []
let g:neospace.private  = []

let s:plug_options = {}
let s:dot_neospace = $HOME.'/.neospace'

let s:TYPE = {
      \ 'string':  type(''),
      \ 'list':    type([]),
      \ 'dict':    type({}),
      \ 'funcref': type(function('call'))
      \ }

function neospace#begin() abort
  " Download vim-plug if unavailable
  if !g:neospace.os.windows
    call s:check_vim_plug()
  endif
  call s:define_command()
  call s:cache()
  call s:check_dot_neospace()
endfunction

function s:download_vim_plug(plug_path)
  echo '==> Downloading vim-plug ......'
  execute '!curl -fLo ' . a:plug_path . ' --create-dirs ' .
        \   'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
endfunction

function s:check_vim_plug()
  let l:plug_path = g:neospace.plug
  if !filereadable(l:plug_path)
    call s:download_vim_plug(l:plug_path)
  endif
endfunction

function s:define_command()
  " MP means MyPlugin
  command! -nargs=+ -bar MP          call s:load_plugin(<args>)
  command! -nargs=+ -bar Layer       call s:layer(<args>)
  command! -nargs=0 -bar LayerCache  call neospace#cache#init()
  command! -nargs=0 -bar LayerStatus call neospace#layer#status()
endfunction

function s:check_dot_neospace()
  if filereadable(expand(s:dot_neospace))
    call s:Source(s:dot_neospace)
    if exists('g:neospace_layers')
      let g:neospace.loaded = g:neospace.loaded + g:neospace_layers
    endif
    let g:mapleader       = get(g:, 'mapleader',      " ")
    let g:maplocalleader  = get(g:, 'maplocalleader', ',')
  else
    call neospace#util#err('.neospace does not exist! Exiting...')
    finish
  endif
endfunction

function s:cache() abort
  let l:info = g:neospace.info
  if filereadable(l:info)
    execute 'source ' . (g:neospace.os.windows ? s:path(l:info) : l:info)
  else
    call neospace#cache#init()
  endif
endfunction

function s:layer(name, ...)
  if index(g:neospace.loaded, a:name) == -1
    call add(g:neospace.loaded, a:name)
  endif
  if a:0 > 1
    return neospace#util#err('Invalid number of arguments (1..2)')
  elseif a:0 == 1
    call s:parse_options(a:1)
  endif
endfunction

function s:to_a(v)
  return type(a:v) == s:TYPE.list ? a:v : [a:v]
endfunction

function s:parse_options(arg)
  let l:type = type(a:arg)
  if l:type == s:TYPE.dict
    if has_key(a:arg, 'exclude')
      for l:excl in s:to_a(a:arg['exclude'])
        call add(g:neospace.excluded, l:excl)
      endfor
    else
      throw 'Invalid option (expected: exclude)'
    endif
  else
    throw 'Invalid argument type (expected: dictionary)'
  endif
endfunction

" This is an only one possible extra argument: plug option, dict
function s:load_plugin(plugin, ...)
  if index(g:neospace.plugins, a:plugin) < 0
    call add(g:neospace.plugins, a:plugin)
  endif
  if a:0 == 1
    let s:plug_options[a:plugin] = a:1
    let l:name = split(a:plugin, '/')[1]
    let l:load = printf("call plug#load('%s')", l:name)
    if has_key(a:1, 'on_event')
      let l:group = 'load/'.a:plugin
      let l:events = join(s:to_a(a:1.on_event), ',')
      let l:filetype = '*'
      if has_key(a:1, 'load')
        let l:load = printf("call %s()", a:1.load)
      endif
      if has_key(a:1, 'for')
        let l:filetype = a:1.for
      endif
      execute "augroup" l:group
      autocmd!
      execute 'autocmd' l:events l:filetype l:load '|' 'autocmd!' l:group
      execute 'augroup END'
    endif
  endif
endfunction

function s:Source(file)
  try
    if filereadable(expand(a:file))
      execute 'source ' . fnameescape(a:file)
    endif
  catch
    let l:msg = 'Caught "' . v:exception . '" in ' . v:throwpoint
    call neospace#util#warn(l:msg)
    call neospace#cache#init()
  endtry
endfunction

function s:path(path)
  return substitute(a:path, '/', '\', 'g')
endfunction

function neospace#end() abort

  " Backward compatibility
  if exists('*Layers')
    call Layers()
  endif

  call s:register_plugin()

  " Make vim-better-default settings can be overrided
  silent! runtime! plugin/default.vim

  call s:config()
  if exists('*UserConfig')
    call UserConfig()
  endif
  call s:post_user_config()
endfunction

function s:register_plugin()
  if !exists('g:neospace_plug_home')
    " https://github.com/junegunn/vim-plug/issues/559
    let g:neospace_plug_home = g:neospace.nvim ? '~/.local/share/nvim/plugged' : '~/.vim/plugged/'
  endif

  call plug#begin(g:neospace_plug_home)

  call s:packages()

  call s:filter_plugins()
  call s:invoke_plug()

  if exists('*UserInit')
    call UserInit()
  endif

  call plug#end()
endfunction

function s:packages()
  " Load Layer packages
  for l:layer in g:neospace.loaded
    try
      let l:layer_init = g:neospace.manifest[l:layer].dir . '/init.vim'
      let l:layer_packages = g:neospace.manifest[l:layer].dir . '/packages.vim'
    catch
      call neospace#cache#init()
    endtry
    call s:Source(l:layer_init)
    call s:Source(l:layer_packages)
  endfor

  " Try private Layer packages
  if exists('g:neospace.private')
    " handle private layer
    for l:private_layer in g:neospace.private
      let l:private_layer_init = g:neospace.private_base . '/' . l:private_layer . '/init.vim'
      let l:private_layer_packages = g:neospace.private_base . '/' . l:private_layer . '/packages.vim'
      if filereadable(expand(l:private_layer_init))
        execute 'source ' . fnameescape(l:private_layer_init)
      endif
      if filereadable(expand(l:private_layer_packages))
        execute 'source ' . fnameescape(l:private_layer_packages)
      endif
    endfor
  endif

  " Load private packages
  let l:private_init = g:neospace.private_base . '/init.vim'
  let l:private_packages = g:neospace.private_base . '/packages.vim'
  if filereadable(expand(l:private_init))
    execute 'source ' . fnameescape(l:private_init)
  endif
  if filereadable(expand(l:private_packages))
    execute 'source ' . fnameescape(l:private_packages)
  endif
endfunction

function s:filter_plugins()
  call filter(g:neospace.plugins, 'index(g:neospace.excluded, v:val) < 0')
endfunction

function s:invoke_plug()
  for l:plugin in g:neospace.plugins
    let l:plug_options = get(s:plug_options, l:plugin, {})
    let l:type = type(l:plug_options)
    call assert_true(l:type == s:TYPE.dict)
    if has_key(l:plug_options, 'defer')
      let l:name = split(l:plugin, '/')[1]
      let l:func = substitute(l:name,'-','_','')

      function! s:deferload(func, name)
        let l:func_s = printf("function Neospace_deferload_%s(timer)\n call plug#load('%s')\n endfunction", a:func, a:name)
        execute l:func_s

        return printf('Neospace_deferload_%s',a:func)
      endfunction

      if !has_key(l:plug_options, 'on')
        let l:plug_options.on = []
      endif
      let l:func = s:deferload(l:func, l:name)
      call timer_start(l:plug_options.defer, l:func)
    endif
    call plug#(l:plugin, l:plug_options)
  endfor
endfunction

function s:config()
  " Load Layer config
  for l:layer in g:neospace.loaded
    call s:Source(g:neospace.manifest[l:layer].dir . '/config.vim')
  endfor

  " Try private Layer config
  if exists('g:neospace.private')
    for l:private_layer in g:neospace.private
      let l:private_layer_config = g:neospace.private_base . '/' . l:private_layer . '/config.vim'
      if filereadable(expand(l:private_layer_config))
        execute 'source ' . fnameescape(l:private_layer_config)
      endif
    endfor
  endif

  " Load private config
  let l:private_config = g:neospace.private_base . '/config.vim'
  if filereadable(expand(l:private_config))
    execute 'source ' . fnameescape(l:private_config)
  endif
endfunction

function s:post_user_config()
  " https://github.com/junegunn/vim-plug/wiki/extra#automatically-install-missing-plugins-on-startup
  augroup checkPlug
    autocmd!
    autocmd VimEnter *
          \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
          \|   echom '[neospace] Some layers need to install the missing plugins first!'
          \|   PlugInstall --sync | q
          \| endif
  augroup END
endfunction

" Util for config.vim and packages.vim
function neospace#load(layer) abort
  return index(g:neospace.loaded, a:layer) > -1 ? 1 : 0
endfunction

