call airline#parts#define_function('vim-gradle-status', 'gradle#statusLine')
let g:airline_section_x = airline#section#create_right(['vista', 'gutentags', 'filetype', 'vim-gradle-status'])

