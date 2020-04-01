function! neospace#has#colorscheme(name) abort
    let pat = 'colors/'.a:name.'.vim'
    return !empty(globpath(&rtp, pat))
endfunction

function! neospace#has#plugin(name) abort
    let plugin1 = 'plugin/'.a:name.'.vim'
    let plugin2 = 'autoload/'.a:name.'.vim'
    return !empty(globpath(&rtp, plugin1)) || !empty(globpath(&rtp, plugin2))
endfunction
