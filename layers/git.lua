local vim = vim

return {
  { 'f-person/git-blame.nvim' },
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
        watch_gitdir = {
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
        diff_opts = {
          internal = true -- If luajit is present
        }
      })
    end
  },

  {
    'TimUntersberger/neogit',
    after = 'nvim-lua/plenary.nvim',
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
      vim.cmd("nnoremap <silent> <Leader>gn :Neogit kind=vsplit<CR>")
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


