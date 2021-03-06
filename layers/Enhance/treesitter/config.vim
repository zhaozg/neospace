lua <<EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
      -- false will disable the whole extension
      enable = true,
      -- list of language that will be disabled
      -- disable = { 'c', 'rust' },
  },
  incremental_selection = {
      enable = true,
      -- disable = { 'cpp', 'lua' },
      keymaps = {                       -- mappings for incremental selection (visual mappings)
        init_selection = 'gnn',         -- maps in normal mode to init the node/scope selection
        node_incremental = "grn",       -- increment to the upper named parent
        scope_incremental = "grc",      -- increment to the upper scope (as defined in locals.scm)
        scope_decremental = "grm",      -- decrement to the previous scope
      }
  },
  node_movement = {                     -- allows cursor movement in node hierarchy
      enable = true,
      -- disable = { 'cpp', 'rust' },
      keymaps = {                       -- mappings for scope movement (normal mappings)
        parent_scope = "<a-k>",         -- default is to move with alt key hold
        child_scope = "<a-j>",
        next_scope = "<a-h>",
        previous_scope = "<a-l>",
      }
  },

  ensure_installed = {'c', 'lua'}
  -- ensure_installed = 'all' -- one of 'all', 'language', or a list of languages
}
EOF
