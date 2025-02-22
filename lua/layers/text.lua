local vim = vim
local map = require('neospace').map

return {
  {
    "cappyzawa/trim.nvim",
    config = function()
      require("trim").setup({})
    end
  },
  {
    'mcauley-penney/visual-whitespace.nvim',
    config = function()
      require("visual-whitespace").setup({
        highlight = { link = "Visual" },
        space_char = '·',
        tab_char = '→',
        nl_char = '↲',
        cr_char = '←',
        enabled = true,
        excluded = {
          filetypes = {},
          buftypes = {}
        }
      })

      vim.keymap.set('n', "<leader>tw", require("visual-whitespace").toggle, {})
    end
  },

  {
    "junegunn/vim-easy-align",
    config = function()
      local wk = require("which-key")
      wk.add({
        { "<leader>a", group = "align" },
        { "<leader>aa", "<Plug>(EasyAlign)", desc = "EasyAlign", mode= { "n" } },
        { "<leader>ai", "<Plug>(LiveEasyAlign)", desc = "LiveEasyAlign", mode= { "n" } },
        { '<leader>a"', '<Plug>(EasyAlign)ip"', desc = 'Align "', mode= { "n", "v" } },
        { "<leader>a#", "<Plug>(EasyAlign)ip#", desc = "Align #", mode= { "n", "v" } },
        { "<leader>a&", "<Plug>(EasyAlign)ip&", desc = "Align &", mode= { "n", "v" } },
        { "<leader>a,", "<Plug>(EasyAlign)ip,", desc = "Align ,", mode= { "n", "v" } },
        { "<leader>a.", "<Plug>(EasyAlign)ip.", desc = "Align .", mode= { "n", "v" } },
        { "<leader>a:", "<Plug>(EasyAlign)ip:", desc = "Align :", mode= { "n", "v" } },
        { "<leader>a=", "<Plug>(EasyAlign)ip=", desc = "Align =", mode= { "n", "v" } },
        { "<leader>ac", "<Plug>(EasyAlign)ip-[ *]+/r0", desc = "AlignCode", mode= { "n", "v" } },
        { "<leader>at", "<Plug>(EasyAlign)ip*|", desc = "AlignTable", mode= { "n", "v" } },
        { "<leader>a|", "<Plug>(EasyAlign)ip|", desc = "Align |", mode= { "n", "v" } },
      })
    end,
  },

  {
    "folke/flash.nvim",
    config = function()
      local flash = require('flash')
      flash.setup()
    end
  },

  {
    "kylechui/nvim-surround",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-treesitter/nvim-treesitter-textobjects"
    },
    config = function()
      require("nvim-surround").setup({
      })
    end,
  },

  {
    "fedepujol/move.nvim",
    config = function()
      require('move').setup({
        line = {
          enable = true, -- Enables line movement
          indent = true  -- Toggles indentation
        },
        block = {
          enable = true, -- Enables block movement
          indent = true  -- Toggles indentation
        },
        word = {
          enable = true, -- Enables word movement
        },
        char = {
          enable = true --  Enables  charmovement
        }
      })
      map("n", "<C-j>", ":MoveLine(1)<CR>")
      map("n", "<C-k>", ":MoveLine(-1)<CR>")
      map("v", "<C-j>", ":MoveBlock(1)<CR>")
      map("v", "<C-k>", ":MoveBlock(-1)<CR>")
      map("n", "<C-l>", ":MoveHChar(1)<CR>")
      map("n", "<C-h>", ":MoveHChar(-1)<CR>")
      map("v", "<C-l>", ":MoveHBlock(1)<CR>")
      map("v", "<C-h>", ":MoveHBlock(-1)<CR>")
      map("n", "<leader>wf", ":MoveWord(1)<CR>")
      map("n", "<leader>wb", ":MoveWord(-1)<CR>")
    end,
  },

  {
    "sindrets/diffview.nvim",
    on = "DiffviewOpen",
    config = function()
      require("diffview").setup({
        diff_binaries = false, -- Show diffs for binaries
        use_icons = true,      -- Requires nvim-web-devicons

        view = {
          -- For more info, see |diffview-config-view.x.layout|.
          default = {
            -- Config for changed files, and staged files in diff views.
            layout = "diff2_vertical",
            winbar_info = false, -- See |diffview-config-view.x.winbar_info|
          },
          merge_tool = {
            -- Config for conflicted files in diff views during a merge or rebase.
            layout = "diff3_mixed",
            disable_diagnostics = true, -- Temporarily disable diagnostics for conflict buffers while in the view.
            winbar_info = true,         -- See |diffview-config-view.x.winbar_info|
          },
          file_history = {
            -- Config for changed files in file history views.
            layout = "diff2_horizontal",
            winbar_info = false, -- See |diffview-config-view.x.winbar_info|
          },
        },
        file_panel = {
          win_config = {
            position = "left", -- One of 'left', 'right', 'top', 'bottom'
            width = 25,        -- Only applies when position is 'left' or 'right'
            height = 10,       -- Only applies when position is 'top' or 'bottom'
          },
        },
      })
    end,
  },

  {
    "folke/zen-mode.nvim",
    config = function()
      require("zen-mode").setup()
    end
  },

  {
    "chrisgrieser/nvim-various-textobjs",
    config = function()
      require("various-textobjs").setup({
        keymaps = {
          useDefaults = true
        }
      })
    end
  },

  {
    "monaqa/dial.nvim",
    config = function ()
      local manipulate = require("dial.map").manipulate
      vim.keymap.set("n", "<C-a>",  function() manipulate("increment", "normal")  end)
      vim.keymap.set("n", "<C-x>",  function() manipulate("decrement", "normal")  end)
      vim.keymap.set("v", "<C-a>",  function() manipulate("increment", "visual")  end)
      vim.keymap.set("v", "<C-x>",  function() manipulate("decrement", "visual")  end)
      vim.keymap.set("n", "g<C-a>", function() manipulate("increment", "gnormal") end)
      vim.keymap.set("n", "g<C-x>", function() manipulate("decrement", "gnormal") end)
      vim.keymap.set("v", "g<C-a>", function() manipulate("increment", "gvisual") end)
      vim.keymap.set("v", "g<C-x>", function() manipulate("decrement", "gvisual") end)
    end
  }
}
