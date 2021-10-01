local vim = vim
local g = vim.g

return {
  {
    'iamcco/markdown-preview.nvim',
    install = function()
      vim.cmd('mkdp#util#install()')
    end,
    init = function()

      g.mkdp_preview_options = {
        disable_sync_scroll = 0,
        hide_yaml_meta = 1,
        sequence_diagrams = {
          theme= 'simple'
        },
        flowchart_diagrams = {
          x= 0,
          y= 0,
          ['line-width'] = 2,
          ['line-length'] = 15,
          ['text-margin'] = 10,
          ['font-size'] = 14,
          ['font-color'] = 'black',
          ['line-color'] = 'black',
          ['element-color'] = 'black',
          ['yes-text'] = 'yes',
          ['no-text'] = 'no',
          ['arrow-end'] = 'block',
          fill = 'white',
          symbols = {
            start= {},
            ['end']= {},
            condition= {['text-margin'] = 0.5},
            inputoutput= {},
            operation= {},
            subroutine= {},
            parallel= {}
          }
        },
        ['content_editable'] = false
      }

      g.mkdp_page_title = '「${name}」'

      g.vim_markdown_fenced_languages = {
        'csharp=cs',
        'c++=cpp',
        'viml=vim',
        'bash=sh',
        'ini=dosini',
        'flowchart=flow',
        'chart=json',
        'sequence-diagrams=sequence'
      }
    end,
    confog = function()
      if vim.fn.executable('prettier') then
        g.neoformat_enabled_markdown= {'prettier'}
        g.neoformat_enabled_vimnote= {'prettier'}
      end
      vim.cmd([[
augroup fmtmarkdown
  autocmd!
  autocmd filetype markdown,vimwiki nmap <buffer> <localleader>p <Plug>MarkdownPreview
  autocmd filetype markdown,vimwiki nmap <buffer> <localleader>s <Plug>MarkdownPreviewStop
  autocmd filetype markdown,vimwiki nmap <buffer> <localleader>t <Plug>MarkdownPreviewToggle
  autocmd filetype markdown,vimwiki nmap <buffer> <localleader>f :TableFormat<CR>
augroup END
      ]])

    end
  }
}

