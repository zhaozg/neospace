--
-- Test faerryn's config.
--

vim.o.rtp = ".," .. vim.o.rtp
vim.o.pp = ".," .. vim.o.pp

local user = require("user")
user.setup({
  async = true,
  path = "./pack/user",
})
local use = user.use

use({
  "antoinemadec/FixCursorHold.nvim",
  init = function()
    vim.g.cursorhold_updatetime = 1000
  end,
})

use("ryvnf/readline.vim")

use("tpope/vim-repeat")

use({
  "norcalli/nvim-colorizer.lua",
  config = function()
    vim.api.nvim_command([[autocmd BufEnter * lua require("colorizer").attach_to_buffer()]])
  end,
})

use("nvim-lua/plenary.nvim")
use("nvim-lua/popup.nvim")
use("nvim-telescope/telescope-fzy-native.nvim")
use({
  "nvim-telescope/telescope.nvim",
  after = {
    "nvim-lua/plenary.nvim",
    "nvim-lua/popup.nvim",
    "nvim-telescope/telescope-fzy-native.nvim",
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup({
      defaults = {
        mappings = { i = { ["<esc>"] = actions.close } },
        file_previewer = require("telescope.previewers").vim_buffer_cat.new,
      },
    })

    telescope.load_extension("fzy_native")

    vim.api.nvim_set_keymap(
      "n",
      "<Leader>f",
      [[<Cmd>lua require("telescope.builtin").find_files{ hidden = true }<CR>]],
      { noremap = true }
    )
    vim.api.nvim_set_keymap(
      "n",
      "<Leader>b",
      [[<Cmd>lua require("telescope.builtin").buffers()<CR>]],
      { noremap = true }
    )
  end,
})

use({
  "lewis6991/gitsigns.nvim",
  after = "nvim-lua/plenary.nvim",
  config = function()
    require("gitsigns").setup({
      signs = {
        add = { hl = "GitGutterAdd", text = "+" },
        change = { hl = "GitGutterChange", text = "~" },
        delete = { hl = "GitGutterDelete", text = "_" },
        topdelete = { hl = "GitGutterDelete", text = "‾" },
        changedelete = { hl = "GitGutterChange", text = "~" },
      },
      keymaps = {},
    })
  end,
})

use("tomtom/tcomment_vim")

use({
  "nvim-treesitter/nvim-treesitter",
  config = function()
    require("nvim-treesitter.configs").setup({ highlight = { enable = true } })
  end,
})

use({
  "ziglang/zig.vim",
  init = function()
    vim.g.zig_fmt_autosave = false
  end,
})

user.flush()
