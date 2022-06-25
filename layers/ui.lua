local vim = vim
local fn = vim.fn -- to call Vim functions e.g. fn.bufnr()
local g = vim.g
local o = vim.o

local fun = require("neospace.fun")
local neospace = require("neospace")

return {

  {
    "kyazdani42/nvim-web-devicons",
    config = function()
      require("nvim-web-devicons").setup({
        -- your personnal icons can go here (to override)
        -- DevIcon will be appended to `name`
        override = {
          zsh = {
            icon = "",
            color = "#428850",
            name = "Zsh",
          },
        },
        -- globally enable default icons (default to false)
        -- will get overriden by `get_icons` option
        default = true,
      })
    end,
  },

  {
    "goolord/alpha-nvim",
    after = "kyazdani42/nvim-web-devicons",
    config = function()
      local alpha = require("alpha")
      local startify = require("alpha.themes.startify")

      local function fix_header(lines)
        local lval = fun.max_by(function(a, b)
          return fn.strwidth(a) > fn.strwidth(b) and a or b
        end, lines)
        lval = fn.strwidth(lval)

        local centered = fun.totable(fun.map(function(line)
          line = string.rep(" ", (o.columns / 2) - (lval / 2)) .. line
          return line
        end, lines))
        return centered
      end
      local function version()
        local t = vim.version()
        return string.format("v%d.%d.%d%s", t.major, t.minor, t.patch, t.api_prerelease and "-dev" or "")
      end

      startify.section.header.val = fix_header({
        [[ _        _______  _______  _______  _______  _______  _______  _______]],
        [[( (    /|(  ____ \(  ___  )(  ____ \(  ____ )(  ___  )(  ____ \(  ____ \]],
        [[|  \  ( || (    \/| (   ) || (    \/| (    )|| (   ) || (    \/| (    \/]],
        [[|   \ | || (__    | |   | || (_____ | (____)|| (___) || |      | (__]],
        [[| (\ \) ||  __)   | |   | |(_____  )|  _____)|  ___  || |      |  __)]],
        [[| | \   || (      | |   | |      ) || (      | (   ) || |      | (]],
        [[| )  \  || (____/\| (___) |/\____) || )      | )   ( || (____/\| (____/\]],
        [[|/    )_)(_______/(_______)\_______)|/       |/     \|(_______/(_______/]],
        "                  neospace " .. neospace.version .. " ＠ nvim " .. version(),
      })
      alpha.setup(startify.opts)
    end,
  },

  --tabline at top
  {
    "kdheepak/tabline.nvim",
    after = "kyazdani42/nvim-web-devicons",
    config = function()
      local tabline = require("tabline")
      tabline.setup({
        enable = false,
        options = {
          section_separators = { "", "" },
          component_separators = { "", "" },
          max_bufferline_percent = 66, -- set to nil by default, and it uses vim.o.columns * 2/3
          show_last_separator = false,
          show_tabs_always = false,
          show_bufnr = true,
          show_devicons = true,
          show_filename_only = true,
        },
      })
    end,
  },

  --tree at left
  {
    "kyazdani42/nvim-tree.lua",
    after = "kyazdani42/nvim-web-devicons",
    config = function()
      require("nvim-tree").setup({
        -- disables netrw completely
        disable_netrw = true,
        -- hijack netrw window on startup
        hijack_netrw = true,
        -- open the tree when running this setup function
        open_on_setup = false,
        -- will not open on setup if the filetype is in this list
        ignore_ft_on_setup = {
          "alpha",
          "dashboard",
        },
        -- opens the tree when changing/opening a new tab if the tree wasn't previously opened
        open_on_tab = false,
        -- hijack the cursor in the tree to put it at the start of the filename
        hijack_cursor = false,
        -- updates the root directory of the tree on `DirChanged` (when your run `:cd` usually)
        update_cwd = false,
        -- update the focused file on `BufEnter`, un-collapses the folders recursively until it finds the file
        update_focused_file = {
          -- enables the feature
          enable = false,
          -- update the root directory of the tree to the one of the folder containing the file if the file is not under the current root directory
          -- only relevant when `update_focused_file.enable` is true
          update_cwd = false,
          -- list of buffer names / filetypes that will not update the cwd if the file isn't found under the current root directory
          -- only relevant when `update_focused_file.update_cwd` is true and `update_focused_file.enable` is true
          ignore_list = {},
        },
        -- configuration options for the system open command (`s` in the tree by default)
        system_open = {
          -- the command to run this, leaving nil should work in most cases
          cmd = nil,
          -- the command arguments as a list
          args = {},
        },

        view = {
          -- width of the window, can be either a number (columns) or a string in `%`, for left or right side placement
          width = 30,
          -- height of the window, can be either a number (columns) or a string in `%`, for top or bottom side placement
          height = 30,
          -- side of the tree, can be one of 'left' | 'right' | 'top' | 'bottom'
          side = "left",
          -- if true the tree will resize itself after opening a file
          mappings = {
            -- custom only false will merge the list with the default mappings
            -- if true, it will only use your list to set the mappings
            custom_only = false,
            -- list of mappings to set on the tree manually
            list = {},
          },
        },
        renderer = {
          add_trailing = true,
          group_empty = true,
          highlight_git = true,
          icons = {
            git_placement = "after",
          },
          indent_markers = {
            enable = true,
          },
        },
      })
      vim.cmd("map <leader>tf <cmd>NvimTreeToggle<CR>")
    end,
  },

  --at right
  {
    "simrat39/symbols-outline.nvim",
    after = "kyazdani42/nvim-web-devicons",
    config = function()
      require("symbols-outline").setup({})
    end,
  },

  --statusline at bottom
  {
    "hoob3rt/lualine.nvim",
    after = { "kyazdani42/nvim-web-devicons", "kdheepak/tabline.nvim" },
    config = function()
      local tabline = require("tabline")
      local gradle_status = require("lualine.components.gradle_status")
      local lsp_status = require("lualine.components.lsp_status")
      require("lualine").setup({
        sections = {
          lualine_a = { "mode", "asyncrun_status" },
          lualine_c = {
            "filename",
            {
              "lsp_status",
              condition = lsp_status.isEnabled,
            },
          },
          lualine_y = {
            "progress",
            {
              "gradle_status",
              condition = gradle_status.isEnabled,
            },
          },
          lualine_z = {
            {
              "diagnostics",
              sources = { "nvim_diagnostic" },
              sections = { "error", "warn", "info" },
            },
            "location",
          },
        },

        tabline = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { tabline.tabline_buffers },
          lualine_x = { tabline.tabline_tabs },
          lualine_y = {},
          lualine_z = {},
        },

        extensions = {
          "fugitive",
          "fzf",
          "nerdtree",
        },
      })
    end,
  },

  {
    "folke/trouble.nvim",
    config = function()
      require("trouble").setup({})
    end,
  },

  {
    "folke/which-key.nvim",
    after = "kyazdani42/nvim-web-devicons",
    config = function()
      require("which-key").setup({
        plugins = {
          marks = true, -- shows a list of your marks on ' and `
          registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
          spelling = {
            enabled = false, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
            suggestions = 20, -- how many suggestions should be shown in the list?
          },
          -- the presets plugin, adds help for a bunch of default keybindings in Neovim
          -- No actual key bindings are created
          presets = {
            operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion
            motions = true, -- adds help for motions
            text_objects = true, -- help for text objects triggered after entering an operator
            windows = true, -- default bindings on <c-w>
            nav = true, -- misc bindings to work with windows
            z = true, -- bindings for folds, spelling and others prefixed with z
            g = true, -- bindings for prefixed with g
          },
        },
        -- add operators that will trigger motion and text object completion
        -- to enable all native operators, set the preset / operators plugin above
        operators = { gc = "Comments" },
        key_labels = {
          -- override the label used to display some keys. It doesn't effect WK in any other way.
          -- For example:
          -- ["<space>"] = "SPC",
          -- ["<cr>"] = "RET",
          -- ["<tab>"] = "TAB",
        },
        icons = {
          breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
          separator = "➜", -- symbol used between a key and it's label
          group = "+", -- symbol prepended to a group
        },
        window = {
          border = "none", -- none, single, double, shadow
          position = "bottom", -- bottom, top
          margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
          padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
        },
        layout = {
          height = { min = 4, max = 25 }, -- min and max height of the columns
          width = { min = 20, max = 50 }, -- min and max width of the columns
          spacing = 3, -- spacing between columns
          align = "left", -- align columns left, center or right
        },
        ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
        hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
        show_help = true, -- show help message on the command line when the popup is visible
        triggers = { "<leader>", "<localleader>" }, -- or specify a list manually
        triggers_blacklist = {
          -- list of mode / prefixes that should never be hooked by WhichKey
          -- this is mostly relevant for key maps that start with a native binding
          -- most people should not need to change this
          i = { "j", "k" },
          v = { "j", "k" },
        },
      })
    end,
  },
}
