local vim = vim
local g = vim.g

return {
  {
    'kvrohit/tasks.nvim',
    config = function()
      local wk = require('which-key')
      wk.register({
         t = {":ToggleTask<CR>", 'ToggleTask'},
         x = {":CancelTask<CR>", 'CancelTask'},
         u = {":UndoTask<CR>", 'UndoTask'}
      },
      { prefix="<localleader>" })
    end
  },
  {
    'iamcco/markdown-preview.nvim',
    install = function()
      vim.cmd('call mkdp#util#install()')
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

      local wk = require('which-key')
      wk.register({
         p = {"<Plug>MarkdownPreview<CR>", 'MarkdownPreview'},
         s = {"<Plug>MarkdownPreviewStop<CR>", 'MarkdownPreviewStop'},
         f = {":TableFormat<CR>", 'TableFormat'}
      },
      { prefix="<localleader>" })
    end
  }
}

