local vim = vim
local map = require('neospace').map

return {
  { "f-person/git-blame.nvim" },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      local signs = require("gitsigns")

      signs.setup({
        signs = {
          add = { hl = "GitSignsAdd", text = "│", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
          change = { hl = "GitSignsChange", text = "│", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
          delete = { hl = "GitSignsDelete", text = "_", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
          topdelete = { hl = "GitSignsDelete", text = "‾", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
          changedelete = { hl = "GitSignsChange", text = "~", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
        },
        numhl = false,
        linehl = false,
        on_attach = function(bufnr)
          local gs = signs
          local function lmap(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end
          -- Navigation
          lmap('n', ']c', function()
            if vim.wo.diff then return ']c' end
            vim.schedule(function() gs.next_hunk() end)
            return '<Ignore>'
          end, {expr=true})

          lmap('n', '[c', function()
            if vim.wo.diff then return '[c' end
            vim.schedule(function() gs.prev_hunk() end)
            return '<Ignore>'
          end, {expr=true})

          -- Actions
          lmap({'n', 'v'}, '<leader>gs', ':Gitsigns stage_hunk<CR>')
          lmap({'n', 'v'}, '<leader>gr', ':Gitsigns reset_hunk<CR>')
          lmap('n', '<leader>gS', gs.stage_buffer)
          lmap('n', '<leader>gu', gs.undo_stage_hunk)
          lmap('n', '<leader>gR', gs.reset_buffer)
          lmap('n', '<leader>gp', gs.preview_hunk)
          lmap('n', '<leader>gb', function() gs.blame_line{full=true} end)
          lmap('n', '<leader>gb', gs.toggle_current_line_blame)
          lmap('n', '<leader>gd', gs.diffthis)
          lmap('n', '<leader>gD', function() gs.diffthis('~') end)
          lmap('n', '<leader>td', gs.toggle_deleted)

          -- Text object
          lmap({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
        end,
        watch_gitdir = {
          interval = 1000,
          follow_files = true,
        },
        current_line_blame = false,
        current_line_blame_opts = {
          delay = 100,
          virt_text_pos = "eol",
        },
        sign_priority = 6,
        update_debounce = 100,
        status_formatter = nil, -- Use default
        word_diff = false,
        diff_opts = {
          internal = true, -- If luajit is present
        },
      })
    end,
  },

  {
    "TimUntersberger/neogit",
    config = function()
      local neogit = require("neogit")
      neogit.setup({
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
          diffview = true,
        },
      })
      map('n', '<Leader>gn', ':Neogit kind=vsplit<CR>')
    end,
  },

  {
    "tpope/vim-fugitive",
    config = function()
      map('n', '<Leader>gf', ':BCommits<CR>')
      map('n', '<Leader>gb', ':Git blame<CR>')
      map('n', '<Leader>gc', ':Git commit<CR>')
      map('n', '<Leader>gd', ':Gdiffsplit<CR>')
      map('n', '<Leader>ge', ':Gedit<CR>')
      map('n', '<Leader>gl', ':Gclog<CR>')
      map('n', '<Leader>gp', ':Git push<CR>')
      map('n', '<Leader>gr', ':Gread<CR>')
      map('n', '<Leader>gs', ':Git<CR>')
      map('n', '<Leader>gw', ':Gwrite<CR>')
    end,
  },
  {
    "junegunn/gv.vim",
    opt = true,
    cmd = { "GV", "GV!" },
    config = function()
      map('n', '<Leader>gv', ':GV<CR>')
      map('n', '<Leader>gV', ':GV!<CR>')
    end,
  },
}
