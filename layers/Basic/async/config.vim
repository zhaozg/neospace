noremap <Plug>AsyncMake   : copen<cr>:AsyncRun make<cr>
noremap <Plug>AsyncClean  : copen<cr>:AsyncRun make clean<cr>
noremap <Plug>AsyncStop   : copen<cr>:AsyncRun!<cr>
noremap <Plug>AsyncTest   : copen<cr>:AsyncRun make test<cr>

nmap <leader>rm <Plug>AsyncMake
nmap <leader>rc <Plug>AsyncClean
nmap <leader>rs <Plug>AsyncStop
nmap <leader>rt <Plug>AsyncTest
