return {

  "nvim-telescope/telescope-symbols.nvim",
  "nvim-telescope/telescope-media-files.nvim",
  "nvim-telescope/telescope-file-browser.nvim",
  "nvim-telescope/telescope-project.nvim",

  {
    "nvim-telescope/telescope.nvim",
    after = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-symbols.nvim",
      "nvim-telescope/telescope-media-files.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
      "nvim-telescope/telescope-project.nvim",
    },
    config = function()
      local project_actions = require("telescope._extensions.project.actions")
      require("telescope").setup({
        extensions = {
          project = {
            base_dirs = {
            },
            hidden_files = true, -- default: false
            order_by = "asc",
            search_by = "title",
            sync_with_nvim_tree = true, -- default false
            -- default for on_project_selected = find project files
            on_project_selected = function(prompt_bufnr)
              -- Do anything you want in here. For example:
              project_actions.change_working_directory(prompt_bufnr, false)
            end
          }
        }
      })
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
