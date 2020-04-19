scriptencoding utf-8

" fzf
nnoremap <silent> <Leader>gf :BCommits<CR>

" vim-fugitive {
nnoremap <silent> <Leader>gb :Gblame<CR>
nnoremap <silent> <Leader>gc :Gcommit<CR>
nnoremap <silent> <Leader>gd :Gvdiff<CR>
nnoremap <silent> <Leader>ge :Gedit<CR>
nnoremap <silent> <Leader>gl :Glog<CR>
nnoremap <silent> <Leader>gp :Git push<CR>
nnoremap <silent> <Leader>gr :Gread<CR>
nnoremap <silent> <Leader>gs :Gstatus<CR>
nnoremap <silent> <Leader>gw :Gwrite<CR>
"}

" vim-gitgutter {
nmap <Leader>gt :GitGutterToggle<CR>
nmap <Leader>gu :GitGutter<CR>
nmap <leader>gz :GitGutterFold<CR>
" }

" gv {
nnoremap <silent> <Leader>gv :GV<CR>
nnoremap <silent> <Leader>gV :GV!<CR>
" }

nmap <leader>tB :BlamerToggle<CR>
