MP 'brooth/far.vim'

if executable('fzf') && isdirectory('/usr/local/opt/fzf')
  MP '/usr/local/opt/fzf'
else
  MP 'junegunn/fzf',            {'dir': '~/.fzf', 'do': './install --all'}
endif
MP 'junegunn/fzf.vim',          {'defer:': 1000}
MP 'conweller/findr.vim',       {'defer:': 1000}
