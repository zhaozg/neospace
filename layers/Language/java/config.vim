noremap <Plug>MavenPackage    : cclose<cr>:copen<cr>:AsyncRun mvn package -B -e -U -Dmaven.test.skip=true<cr>
noremap <Plug>MavenDeploy     : cclose<cr>:copen<cr>:AsyncRun mvn deploy -B -e -U-Dmaven.test.skip=true<cr>
noremap <Plug>MavenInstall    : cclose<cr>:copen<cr>:AsyncRun mvn install -B -e -U -Dmaven.test.skip=true<cr>
noremap <Plug>PackageWithTest : cclose<cr>:copen<cr>:AsyncRun mvn package -B -e -U<cr>
noremap <Plug>MavenTest       : cclose<cr>:copen<cr>:AsyncRun mvn test -B -e -U<cr>
noremap <Plug>MavenCompile    : cclose<cr>:copen<cr>:AsyncRun mvn compile<cr>
noremap <Plug>MavenClean      : cclose<cr>:copen<cr>:AsyncRun mvn clean<cr>
noremap <Plug>MavenStop       : AsyncRun[!]<cr>

if executable('astyle') && exists("g:neoformat_java_astyle")==0
  let g:neoformat_java_astyle = {
        \ 'exe': 'astyle',
        \ 'args': ['--mode=java', '--indent=spaces=2'],
        \ 'stdin': 1
        \ }
  let g:neoformat_enabled_java = ['astyle']
endif

augroup plgmaven
  autocmd!
  autocmd filetype java setlocal ts=2 sw=2 et tw=79 fen fdm=marker
  autocmd filetype java call neospace#leader#register('m', {'name': 'maven'}, 1)
  autocmd filetype java nmap <buffer> <localleader>mp <Plug>MavenPackage
  autocmd filetype java nmap <buffer> <localleader>mP <Plug>PackageWithTest
  autocmd filetype java nmap <buffer> <localleader>md <Plug>MavenDeploy
  autocmd filetype java nmap <buffer> <localleader>mi <Plug>MavenInstall
  autocmd filetype java nmap <buffer> <localleader>mt <Plug>MavenTest
  autocmd filetype java nmap <buffer> <localleader>mc <Plug>MavenCompile
  autocmd filetype java nmap <buffer> <localleader>mC <Plug>MavenClean
  autocmd filetype java nmap <buffer> <localleader>ms <Plug>MavenStop
augroup END
