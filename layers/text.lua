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
  {
    'sindrets/diffview.nvim',
    config = function()
      local cb = require'diffview.config'.diffview_callback

      require'diffview'.setup {
        diff_binaries = false,    -- Show diffs for binaries
        use_icons = true,         -- Requires nvim-web-devicons
        file_panel = {
          win_config = {
            position = "left",      -- One of 'left', 'right', 'top', 'bottom'
            width = 35,             -- Only applies when position is 'left' or 'right'
            height = 10             -- Only applies when position is 'top' or 'bottom'
          }
        },
        key_bindings = {
          disable_defaults = false,                   -- Disable the default key bindings
          -- The `view` bindings are active in the diff buffers, only when the current
          -- tabpage is a Diffview.
          view = {
            ["<tab>"]     = cb("select_next_entry"),  -- Open the diff for the next file
            ["<s-tab>"]   = cb("select_prev_entry"),  -- Open the diff for the previous file
            ["<leader>e"] = cb("focus_files"),        -- Bring focus to the files panel
            ["<leader>b"] = cb("toggle_files"),       -- Toggle the files panel.
          },
          file_panel = {
            ["j"]             = cb("next_entry"),         -- Bring the cursor to the next file entry
            ["<down>"]        = cb("next_entry"),
            ["k"]             = cb("prev_entry"),         -- Bring the cursor to the previous file entry.
            ["<up>"]          = cb("prev_entry"),
            ["<cr>"]          = cb("select_entry"),       -- Open the diff for the selected entry.
            ["o"]             = cb("select_entry"),
            ["<2-LeftMouse>"] = cb("select_entry"),
            ["-"]             = cb("toggle_stage_entry"), -- Stage / unstage the selected entry.
            ["S"]             = cb("stage_all"),          -- Stage all entries.
            ["U"]             = cb("unstage_all"),        -- Unstage all entries.
            ["X"]             = cb("restore_entry"),      -- Restore entry to the state on the left side.
            ["R"]             = cb("refresh_files"),      -- Update stats and entries in the file list.
            ["<tab>"]         = cb("select_next_entry"),
            ["<s-tab>"]       = cb("select_prev_entry"),
            ["<leader>e"]     = cb("focus_files"),
            ["<leader>b"]     = cb("toggle_files"),
          }
        }
      }
    end
  },

  "folke/zen-mode.nvim"
}
