return {
  "nvim-telescope/telescope.nvim",
  "nvim-telescope/telescope-symbols.nvim",
  "nvim-telescope/telescope-media-files.nvim",

  {
    "nvim-telescope/telescope-project.nvim",
    config = function()
      require("telescope").setup({})
      local wk = require("which-key")
      local builtin = require("telescope.builtin")
      local function project(opts)
        opts = opts or {}
        require("telescope").extensions.project.project(opts)
      end

      wk.register({
        f = {
          name = "find", -- optional group name

          b = { builtin.buffers, "buffers" },
          c = { builtin.commands, "commands" },
          f = { builtin.find_files, "files" },
          g = { builtin.live_grep, "grep" },
          h = { builtin.help_tags, "help" },
          o = { builtin.oldfiles, "recent", noremap = false },
          m = { builtin.keymaps, "maps" },

          d = { builtin.lsp_definitions, "definitions" },
          i = { builtin.lsp_implementations, "implementations" },
          r = { builtin.lsp_references, "references" },
          s = { builtin.lsp_workspace_symbols, "symbols" },
          l = { builtin.lsp_dynamic_workspace_symbols, "lists" },

          C = { builtin.git_commits, "Commits" },
          B = { builtin.git_bcommits, "Buffer Commits" },

          T = { builtin.treesitter, "treesitter" },

          N = { ":Telescope notify<CR>", "notify" },

          p = { project, "project" },
        },
      }, { prefix = "<leader>" })
    end,
  },
}
