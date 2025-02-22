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
      require('telescope').load_extension('media_files')

      local project_actions = require("telescope._extensions.project.actions")
      require("telescope").setup({
        extensions = {
          media_files = {
            -- filetypes whitelist
            -- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
            filetypes = {"png", "webp", "jpg", "jpeg"},
            -- find command (defaults to `fd`)
            find_cmd = "rg"
          },
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

      wk.add({
        { "<leader>f", group = "find" },
        { "<leader>fb", builtin.buffers, desc="buffers" },
        { "<leader>fc", builtin.commands, desc="commands" },
        { "<leader>ff", builtin.find_files, desc="files" },
        { "<leader>fg", builtin.live_grep, desc="grep" },
        { "<leader>fh", builtin.help_tags, desc="help" },
        { "<leader>fo", builtin.oldfiles, desc="recent", noremap = false },
        { "<leader>fm", builtin.keymaps, desc="maps" },
        { "<leader>fd", builtin.lsp_definitions, desc="definitions" },
        { "<leader>fi", builtin.lsp_implementations, desc="implementations" },
        { "<leader>fr", builtin.lsp_references, desc="references" },
        { "<leader>fs", builtin.lsp_workspace_symbols, desc="symbols" },
        { "<leader>fl", builtin.lsp_dynamic_workspace_symbols, desc="lists" },
        { "<leader>fC", builtin.git_commits, desc="Commits" },
        { "<leader>fB", builtin.git_bcommits, desc="Buffer Commits" },
        { "<leader>fT", builtin.treesitter, desc="treesitter" },
        { "<leader>fN", ":Telescope notify<CR>", desc="notify" },
        { "<leader>fp", project, desc="project" }
      })
    end,
  },
}
