return {
  {
    "wannesm/wmgraphviz.vim",
    ft = { "dot", "gv", "markdown" },
    config = function()
      vim.cmd("autocmd FileType flow nmap <silent> <buffer> <leader>lf <Plug>GenerateFlowDiagram")
    end,
  },
  {
    "zhaozg/vim-flow-diagram",
    ft = { "markdown", "flow", "flowchart" },
  },
  {
    "zhaozg/vim-diagram",
    ft = { "markdown", "sequence" },
  },
}
