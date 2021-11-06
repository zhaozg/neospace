return {
  {
    'wannesm/wmgraphviz.vim',
    ['for'] = {'dot'},
    config = function()
      vim.cmd("autocmd FileType flow nmap <silent> <buffer> <leader>lf <Plug>GenerateFlowDiagram")
    end
  },
  {
    'zhaozg/vim-flow-diagram',
    ['for'] = {'markdown', 'flow', 'flowchart'}
  },
  {
    'zhaozg/vim-diagram',
    ['for'] = {'markdown', 'sequence'}
  }
}

