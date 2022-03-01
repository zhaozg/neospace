local vim = vim
local g = vim.g

return {
  'justinmk/vim-sneak',
  'ggandor/lightspeed.nvim',
  'tpope/vim-surround',
  {
    'junegunn/vim-easy-align',
    config = function()
      local wk = require'which-key'

      wk.register({
          a = {
            name = "+align",
            ['a'] = { "<Plug>(EasyAlign)",            "EasyAlign" },
            ['i'] = { "<Plug>(LiveEasyAlign)",        "LiveEasyAlign" },
            ['='] = { "<Plug>(EasyAlign)ip=",         "Align =" },
            ['t'] = { "<Plug>(EasyAlign)ip*|",        "AlignTable" },
            ['|'] = { "<Plug>(EasyAlign)ip|",         "Align |" },
            [':'] = { "<Plug>(EasyAlign)ip:",         "Align :" },
            ['.'] = { "<Plug>(EasyAlign)ip.",         "Align ." },
            [','] = { "<Plug>(EasyAlign)ip,",         "Align ," },
            ['&'] = { "<Plug>(EasyAlign)ip&",         "Align &" },
            ['#'] = { "<Plug>(EasyAlign)ip#",         "Align #" },
            ['"'] = { "<Plug>(EasyAlign)ip\"",        "Align \"" },
            ['c'] = { "<Plug>(EasyAlign)ip-[ *]+/r0", "AlignCode" },
          }
      }, { prefix="<leader>" })

      wk.register({
          a = {
            name = "+align",
            ['='] = { "<Plug>(EasyAlign)=",         "Align =" },
            ['t'] = { "<Plug>(EasyAlign)*|",        "AlignTable" },
            ['|'] = { "<Plug>(EasyAlign)|",         "Align |" },
            [':'] = { "<Plug>(EasyAlign):",         "Align :" },
            ['.'] = { "<Plug>(EasyAlign).",         "Align ." },
            [','] = { "<Plug>(EasyAlign),",         "Align ," },
            ['&'] = { "<Plug>(EasyAlign)&",         "Align &" },
            ['#'] = { "<Plug>(EasyAlign)#",         "Align #" },
            ['"'] = { "<Plug>(EasyAlign)\"",        "Align \"" },
            ['c'] = { "<Plug>(EasyAlign)-[ *]+/r0", "AlignCode" },
          }
      }, { prefix="<leader>", mode = 'v' })
    end
  },
  {
    'fedepujol/move.nvim',
    config = function()
      vim.api.nvim_set_keymap('n', '<C-j>', ":MoveLine(1)<CR>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<C-k>', ":MoveLine(-1)<CR>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap('v', '<C-j>', ":MoveBlock(1)<CR>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap('v', '<C-k>', ":MoveBlock(-1)<CR>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<C-l>', ":MoveHChar(1)<CR>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<C-h>', ":MoveHChar(-1)<CR>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap('v', '<C-l>', ":MoveHBlock(1)<CR>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap('v', '<C-h>', ":MoveHBlock(-1)<CR>", { noremap = true, silent = true })
    end
  },
  {
    'ntpeters/vim-better-whitespace',
    init = function()
      g.better_whitespace_enabled     = 1
      g.strip_whitespace_on_save      = 0
      g.strip_only_modified_lines     = 1
      g.better_whitespace_operator    = '<leader>xs'
      g.show_spaces_that_precede_tabs = 1
    end,
    config = function()
      vim.cmd("nnoremap ]w :NextTrailingWhitespace<CR>")
      vim.cmd("nnoremap [w :PrevTrailingWhitespace<CR>")
    end
  },
  {
    'junegunn/Goyo.vim',
    cmd = {'Goyo'},
    config = function()
      vim.cmd('autocmd! User GoyoEnter Limelight')
      vim.cmd('autocmd! User GoyoLeave Limelight!')
    end
  },
  {
    'junegunn/limelight.vim',
    cmd = {'Goyo'}
  }
}
