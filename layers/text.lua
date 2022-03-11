local vim = vim
local g = vim.g

return {
  {
    'phaazon/hop.nvim',
    config = function()
      local hop = require'hop'
      local hint = require'hop.hint'

      -- you can configure Hop the way you like here; see :h hop-config
      hop.setup{}
      vim.keymap.set('n', 'f', function()
        hop.hint_char1({
          direction = hint.HintDirection.AFTER_CURSOR,
          current_line_only = true
        })
      end)
      vim.keymap.set('n', 'F', function()
        hop.hint_char1({
          direction = hint.HintDirection.BEFORE_CURSOR,
          current_line_only = true
        })
      end)
      vim.keymap.set('v', 'f', function()
        hop.hint_char1({
          direction = hint.HintDirection.AFTER_CURSOR,
          current_line_only = true,
          inclusive_jump = true
        })
      end)
      vim.keymap.set('v', 'F', function()
        hop.hint_char1({
          direction = hint.HintDirection.BEFORE_CURSOR,
          current_line_only = true,
          inclusive_jump = true
        })
      end)
      vim.keymap.set('', 't', function()
        hop.hint_char1({
          direction = hint.HintDirection.AFTER_CURSOR,
          current_line_only = true
        })
      end)
      vim.keymap.set('', 'T', function()
        hop.hint_char1({
          direction = hint.HintDirection.BEFORE_CURSOR,
          current_line_only = true
        })
      end)

      vim.keymap.set('', '<C-s>', function()
        hop.hint_char2({})
      end)
      vim.keymap.set('', '<C-w>', function()
        hop.hint_words({})
      end)
      vim.keymap.set('n', '<C-x>', function()
        hop.hint_lines_skip_whitespace({})
      end)
    end
  },
  {
    'tpope/vim-surround',
    init = function()
      g.surround_no_mappings = 1
    end,
    config = function()
      vim.cmd("nmap ds       <Plug>Dsurround")
      vim.cmd("nmap cs       <Plug>Csurround")
      vim.cmd("nmap cS       <Plug>CSurround")
      vim.cmd("nmap ys       <Plug>Ysurround")
      vim.cmd("nmap yS       <Plug>YSurround")
      vim.cmd("nmap yss      <Plug>Yssurround")
      vim.cmd("nmap ySs      <Plug>YSsurround")
      vim.cmd("nmap ySS      <Plug>YSsurround")
      vim.cmd("xmap gs       <Plug>VSurround")
      vim.cmd("xmap gS       <Plug>VgSurround")
    end
  },
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
  "folke/zen-mode.nvim"
}
