autocmd FileType flow nmap call neospace#leader#register('l', {'name': 'graphviz'}, 1)
autocmd FileType flow nmap <silent> <buffer> <localleader>lf <Plug>GenerateFlowDiagram
