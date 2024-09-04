return {
  {
    "nvim-treesitter/nvim-treesitter",
    init = function()
      require("nvim-treesitter.install").prefer_git = true
    end,
    config = function()
      require("nvim-treesitter.configs").setup({
        tree_docs = {
          enable = true,
          keymaps = {
            doc_node_at_cursor = "gdd",
            doc_all_in_range = "gdd",
          },
        },

        highlight = {
          -- false will disable the whole extension
          enable = true,
          -- list of language that will be disabled
          disable = function(lang, bufnr)
            _ = lang -- avoid unused
            return vim.api.nvim_buf_line_count(bufnr) > 2048
          end,
          additional_vim_regex_highlighting = false,
        },

        incremental_selection = {
          enable = false,
          -- disable = { 'cpp', 'lua' },
          -- mappings for incremental selection (visual mappings)
          keymaps = {
            -- maps in normal mode to init the node/scope selection
            init_selection = "gnn",
            -- increment to the upper named parent
            node_incremental = "grn",
            -- increment to the upper scope (as defined in locals.scm)
            scope_incremental = "grc",
            -- decrement to the previous scope
            scope_decremental = "grm",
          },
        },

        node_movement = { -- allows cursor movement in node hierarchy
          enable = true,
          -- disable = { 'cpp', 'rust' },
          keymaps = { -- mappings for scope movement (normal mappings)
            parent_scope = "<a-k>", -- default is to move with alt key hold
            child_scope = "<a-j>",
            next_scope = "<a-h>",
            previous_scope = "<a-l>",
          },
        },

        indent = {
          enable = true,
        },

        refactor = {
          highlight_definitions = {
            enable = true,
            -- Set to false if you have an `updatetime` of ~100.
            clear_on_cursor_move = true,
          },
          highlight_current_scope = {
            enable = true
          },
          smart_rename = {
            enable = true,
            -- Assign keymaps to false to disable them, e.g. `smart_rename = false`.
            keymaps = {
              smart_rename = "grr",
            },
          },
          navigation = {
            enable = true,
            -- Assign keymaps to false to disable them, e.g. `goto_definition = false`.
            keymaps = {
              goto_definition = "gnd",
              list_definitions = "gnD",
              list_definitions_toc = "gO",
              goto_next_usage = "<a-*>",
              goto_previous_usage = "<a-#>",
            },
          },
        },

        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
            },
          },
        },
        ensure_installed = { "c", "cpp", "lua", "bash", "cmake", "java", "make", "vim", "zig", "yaml" },
        -- {'c', 'lua'}
        -- ensure_installed = 'all' -- one of 'all', 'language', or a list of languages
      })
      vim.opt.foldmethod = "expr"
      vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-refactor",
    after = "nvim-treesitter/nvim-treesitter",
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    after = "nvim-treesitter/nvim-treesitter",
  },
  {
    "nvim-treesitter/nvim-tree-docs",
    after = "nvim-treesitter/nvim-treesitter",
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    after = "nvim-treesitter/nvim-treesitter",
  },
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    after = "nvim-treesitter/nvim-treesitter",
    config = function()
      require('ts_context_commentstring').setup {
        enable = true,
        enable_autocmd = false,
      }
    end
  }
}
