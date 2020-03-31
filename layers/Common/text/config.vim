autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

" vim-easy-align {
call neospace#leader#register('a', {'name': '+align'}, 0)
noremap <silent> <Plug>help :help easy-align<cr>
map <leader>ah <Plug>help

" Start interactive EasyAlign in visual mode (e.g. vipxa)
xmap <Leader>aa <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. xaip)
nmap <Leader>aa <Plug>(EasyAlign)

map <Leader>ai <Plug>(LiveEasyAlign)

vmap <Leader>a= <Plug>(EasyAlign)=
nmap <Leader>a= <Plug>(EasyAlign)ip=

call neospace#leader#register('at', 'EasyTable', 0)
vmap <Leader>at <Plug>(EasyAlign)*\|
nmap <Leader>at <Plug>(EasyAlign)ip*\|

vmap <Leader>a\| <Plug>(EasyAlign)\|
nmap <Leader>a\| <Plug>(EasyAlign)ip\|

vmap <Leader>a: <Plug>(EasyAlign):
nmap <Leader>a: <Plug>(EasyAlign)ip:

vmap <Leader>a. <Plug>(EasyAlign).
nmap <Leader>a. <Plug>(EasyAlign)ip.

vmap <Leader>a, <Plug>(EasyAlign),
nmap <Leader>a, <Plug>(EasyAlign)ip,

vmap <Leader>a& <Plug>(EasyAlign)&
nmap <Leader>a& <Plug>(EasyAlign)ip&

vmap <Leader>a# <Plug>(EasyAlign)#
nmap <Leader>a# <Plug>(EasyAlign)ip#

vmap <Leader>a" <Plug>(EasyAlign)"
nmap <Leader>a" <Plug>(EasyAlign)ip"

call neospace#leader#register('ac', 'EasyCode', 0)
vmap <Leader>ac <Plug>(EasyAlign)-/[ *]\+/r0
nmap <Leader>ac <Plug>(EasyAlign)ip-/[ *]\+/r0

" }

