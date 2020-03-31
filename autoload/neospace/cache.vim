function neospace#cache#init() abort
  if has('python') || has('python3')
    let s:py_exe = has('python') ? get(g:, 'python_host_prog') : get(g:, 'python3_host_prog')
    try
      call s:py_init()
    catch
      call s:init()
    endtry
  else
    call s:init()
  endif
endfunction

function s:init()
  let l:topic_base = g:neospace.layers_base
  let l:topics_dir = split(globpath(l:topic_base, '*'), '\n')
  let l:topics_path = filter(l:topics_dir, 'isdirectory(v:val)')
  let l:tps = deepcopy(l:topics_path)

  let l:topic2layers = {}
  let g:neospace.manifest = {}
  for l:topic in l:topics_path
    let l:t_k = fnamemodify(l:topic, ":t")
    let l:layers = split(globpath(l:topic, '*'), '\n')
    let l:lys = deepcopy(l:layers)
    let l:layer_name = map(l:lys, 'fnamemodify(v:val, ":t")')
    let l:topic2layers[l:t_k] = l:layer_name

    for l:layer in l:layers
      let l:l_k = fnamemodify(l:layer, ":t")
      let g:neospace.manifest[l:l_k] = {'dir': l:layer}
    endfor
  endfor

  let g:neospace.topics = l:topic2layers

  let l:private_base = g:neospace.base."/private"
  let l:private_dir = split(globpath(l:private_base, '*'), '\n')
  let l:private_path = filter(l:private_dir, 'isdirectory(v:val)')

  let s:cache = g:neospace.info
  call writefile([printf("let g:neospace.topics = %s", g:neospace.topics)], s:cache, "a")
  call writefile([printf("let g:neospace.manifest = %s", g:neospace.manifest)], s:cache, "a")
  if len(l:private_path)
    let g:neospace.private = map(l:private_path, 'fnamemodify(v:val, ":t")')
    call writefile([printf("let g:neospace.private = %s", g:neospace.private)], s:cache, "a")
  endif
endfunction

function s:py_init()
execute s:py_exe "<< EOF"
import os
import vim

neospace_base = vim.eval('g:neospace.base')
topic_base = vim.eval('g:neospace.layers_base')
private_base = vim.eval('g:neospace.private_base')

topics_path = [
    os.path.join(topic_base, f) for f in os.listdir(topic_base)
    if os.path.isdir(os.path.join(topic_base, f))
]
private = [
    f for f in os.listdir(private_base)
    if os.path.isdir(os.path.join(private_base, f))
]

neospace_topics = {}
neospace_manifest = {}

for topic in topics_path:
    layers = [
        f for f in os.listdir(topic) if os.path.isdir(os.path.join(topic, f))
    ]
    neospace_topics[os.path.split(topic)[-1]] = layers
    for layer in layers:
        neospace_manifest[layer] = {'dir': topic + '/' + layer}

vim.command("let g:neospace.topics = %s" % neospace_topics)
vim.command("let g:neospace.manifest = %s" % neospace_manifest)
if len(private):
    vim.command("let g:neospace.private = %s" % private)

f = open(vim.eval('g:neospace.info'), 'w')
f.write("let g:neospace.topics = %s\n" % neospace_topics)
f.write("let g:neospace.manifest = %s\n" % neospace_manifest)
if len(private):
    f.write("let g:neospace.private = %s\n" % private)
f.close()

EOF
endfunction
