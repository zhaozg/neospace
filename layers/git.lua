return {
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      local signs = require('gitsigns')

      signs.setup({
        signs = {
          add          = {hl = 'GitSignsAdd'   , text = '│', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
          change       = {hl = 'GitSignsChange', text = '│', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
          delete       = {hl = 'GitSignsDelete', text = '_', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
          topdelete    = {hl = 'GitSignsDelete', text = '‾', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
          changedelete = {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
        },
        numhl = false,
        linehl = false,
        keymaps = {
          -- Default keymap options
          noremap = true,

          ['n ]c'] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns.actions\".next_hunk()<CR>'"},
          ['n [c'] = { expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns.actions\".prev_hunk()<CR>'"},

          ['n <leader>hs'] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
          ['v <leader>hs'] = '<cmd>lua require"gitsigns".stage_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
          ['n <leader>hu'] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
          ['n <leader>hr'] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
          ['v <leader>hr'] = '<cmd>lua require"gitsigns".reset_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
          ['n <leader>hR'] = '<cmd>lua require"gitsigns".reset_buffer()<CR>',
          ['n <leader>hp'] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
          ['n <leader>hb'] = '<cmd>lua require"gitsigns".blame_line(true)<CR>',

          -- Text objects
          ['o ih'] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>',
          ['x ih'] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>'
        },
        watch_index = {
          interval = 1000,
          follow_files = true
        },
        current_line_blame = false,
        current_line_blame_opts = {
	  delay = 100,
          virt_text_pos = 'eol'
	},
        sign_priority = 6,
        update_debounce = 100,
        status_formatter = nil, -- Use default
        word_diff = false,
        use_internal_diff = true,  -- If luajit is present
      })
    end
  },

  {
    'TimUntersberger/neogit',
    config = function()
      local neogit = require('neogit')
      neogit.setup {
        disable_signs = false,
        disable_context_highlighting = false,
        disable_commit_confirmation = false,
        -- customize displayed signs
        signs = {
          -- { CLOSED, OPENED }
          section = { ">", "v" },
          item = { ">", "v" },
          hunk = { "", "" },
        },
        integrations = {
          diffview = true
        }
      }
      vim.cmd("nnoremap <silent> <Leader>gn :Neogit<CR>")
    end
  },

  {
    'sindrets/diffview.nvim',
    config = function()
      local cb = require'diffview.config'.diffview_callback

      require'diffview'.setup {
        diff_binaries = false,    -- Show diffs for binaries
        file_panel = {
          position = "left",      -- One of 'left', 'right', 'top', 'bottom'
          width = 35,             -- Only applies when position is 'left' or 'right'
          height = 10,            -- Only applies when position is 'top' or 'bottom'
          use_icons = true        -- Requires nvim-web-devicons
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

  {
    'tpope/vim-fugitive',
    config = function()
      vim.cmd('nnoremap <silent> <Leader>gf :BCommits<CR>')
      vim.cmd('nnoremap <silent> <Leader>gb :Git blame<CR>')
      vim.cmd('nnoremap <silent> <Leader>gc :Git commit<CR>')
      vim.cmd('nnoremap <silent> <Leader>gd :Gdiffsplit<CR>')
      vim.cmd('nnoremap <silent> <Leader>ge :Gedit<CR>')
      vim.cmd('nnoremap <silent> <Leader>gl :Gclog<CR>')
      vim.cmd('nnoremap <silent> <Leader>gp :Git push<CR>')
      vim.cmd('nnoremap <silent> <Leader>gr :Gread<CR>')
      vim.cmd('nnoremap <silent> <Leader>gs :Git<CR>')
      vim.cmd('nnoremap <silent> <Leader>gw :Gwrite<CR>')
    end
  },
  {
    'junegunn/gv.vim',
    opt = true,
    cmd = {'GV', 'GV!'},
    config = function()
      vim.cmd("nnoremap <silent> <Leader>gv :GV<CR>")
      vim.cmd("nnoremap <silent> <Leader>gV :GV!<CR>")
    end
  }
}


