local vim = vim
local fn  = vim.fn   -- to call Vim functions e.g. fn.bufnr()
local g   = vim.g
local o   = vim.o

local fun = require'neospace.fun'

return {
  {
    'mhinz/vim-startify',
    init = function()
      g.startify_list_order = {
        {'   Project:'},
        'dir',
        {'   Recent Files:'},
        'files',
        {'   Sessions:'},
        'sessions',
        {'   Bookmarks:'},
        'bookmarks',
        {'   Commands:'},
        'commands',
      }
      g.startify_change_to_vcs_root = 0
      g.startify_session_autoload = 1
      g.startify_change_to_dir = 0

      --function! s:get_nvim_version()
      --  redir => l:s
      --  silent! version
      --  redir END
      --  return matchstr(l:s, 'NVIM v\zs[^\n]*')
      --endfunction
      --let s:version = 'nvim '.s:get_nvim_version() : 'vim '.v:version

      local function fix_header(lines)
	local lval = fun.max_by(function(a, b)
	  return fn.strwidth(a) > fn.strwidth(b) and a or b
	end, lines)
	lval = fn.strwidth(lval)

	local centered = fun.totable(fun.map(function(line)
	  line = string.rep(' ', (o.columns/2)-(lval/2)) .. line
	  return line
	end, lines))
	return centered
      end

      local function version()
         local s = vim.cmd('version')
	 print(s:find('NVIM ([^\n]+)'))
      end
      --version()

      local custom_header = {
        [[ _        _______  _______  _______  _______  _______  _______  _______]],
        [[( (    /|(  ____ \(  ___  )(  ____ \(  ____ )(  ___  )(  ____ \(  ____ \]],
        [[|  \  ( || (    \/| (   ) || (    \/| (    )|| (   ) || (    \/| (    \/]],
        [[|   \ | || (__    | |   | || (_____ | (____)|| (___) || |      | (__]],
        [[| (\ \) ||  __)   | |   | |(_____  )|  _____)|  ___  || |      |  __)]],
        [[| | \   || (      | |   | |      ) || (      | (   ) || |      | (]],
        [[| )  \  || (____/\| (___) |/\____) || )      | )   ( || (____/\| (____/\]],
        [[|/    )_)(_______/(_______)\_______)|/       |/     \|(_______/(_______/]],
       '             [ neospace   .. nver ..  ＠ . s:version . '
      }
      g.startify_custom_header = fix_header(custom_header)
    end,
    config = function()
      vim.cmd[[autocmd User Startified colorscheme gruvbox]]
    end
  },

  --tabline at top
  {
    'kdheepak/tabline.nvim',
    init = function()
      g.tabline_show_bufnr = false
      g.tabline_show_filename_only = true
    end,
    config = function()
      local tabline = require'tabline'
      tabline.setup {
        enable = false,
        options = {
        -- If lualine is installed tabline will use separators configured in lualine by default.
        -- These options can be used to override those settings.
          section_separators = {'', ''},
          component_separators = {'', ''},
          max_bufferline_percent = 66, -- set to nil by default, and it uses vim.o.columns * 2/3
          always_show_tabs = false, -- by default, this shows tabs only when there are more than one tab or if the first tab is named
        }
      }
    end
  },

  --tree at left
  {
    'kyazdani42/nvim-tree.lua',
    init = function()
      -- empty by default
      g.nvim_tree_ignore = { '.git', 'node_modules', '.cache' }
      -- 0 by default
      g.nvim_tree_gitignore = 1
      g.nvim_tree_auto_open = 1 --0 by default, opens the tree when typing `vim $DIR` or `vim`
      g.nvim_tree_auto_close = 1 --0 by default, closes the tree when it's the last window
      g.nvim_tree_auto_ignore_ft = { 'startify', 'dashboard' } -- empty by default, don't auto open tree on specific filetypes.
      g.nvim_tree_follow = 1 --0 by default, this option allows the cursor to be updated when entering a buffer
      g.nvim_tree_indent_markers = 1 --0 by default, this option shows indent markers when folders are open
      g.nvim_tree_hide_dotfiles = 1 --0 by default, this option hides files and folders starting with a dot `.`
      g.nvim_tree_git_hl = 1 --"0 by default, will enable file highlight for git attributes (can be used without the icons).
      g.nvim_tree_root_folder_modifier = ':~' --"This is the default. See :help filename-modifiers for more options
      g.nvim_tree_tab_open = 1 --"0 by default, will open the tree when entering a new tab and the tree was previously open
      g.nvim_tree_width_allow_resize  = 1 --"0 by default, will not resize the tree when opening a file
      g.nvim_tree_disable_netrw = 0 --"1 by default, disables netrw
      g.nvim_tree_hijack_netrw = 0 --"1 by default, prevents netrw from automatically opening when opening directories (but lets you keep its other utilities)
      g.nvim_tree_add_trailing = 1 --"0 by default, append a trailing slash to folder names
      g.nvim_tree_group_empty = 1 --" 0 by default, compact folders that only contain a single folder into one node in the file tree
      g.nvim_tree_lsp_diagnostics = 1 --"0 by default, will show lsp diagnostics in the signcolumn. See :help nvim_tree_lsp_diagnostics
      g.nvim_tree_special_files = { 'README.md', 'Makefile', 'MAKEFILE' } -- " List of filenames that gets highlighted with NvimTreeSpecialFile
      g.nvim_tree_show_icons = { ['git']= 1, ['folders']= 1, ['files']= 1 }

      g.nvim_tree_icons = {
        ['default'] =        '',
        ['symlink'] =        '',
        ['git'] = {
          ['unstaged'] =     "✗",
          ['staged'] =       "✓",
          ['unmerged'] =     "",
          ['renamed'] =      "➜",
          ['untracked'] =    "★",
          ['deleted'] =      "",
         },
        ['folder'] = {
          ['arrow_open'] =   "",
          ['arrow_closed'] = "",
          ['default'] =      "",
          ['open'] =         "",
          ['empty'] =        "",
          ['empty_open'] =   "",
          ['symlink'] =      "",
          ['symlink_open'] = "",
         },
         ['lsp'] = {
           ['hint'] = "",
           ['info'] = "",
           ['warning'] = "",
           ['error'] = "",
         }
      }
    end,
    config = function()
      vim.cmd("map <leader>tf <cmd>NvimTreeToggle<CR>")
    end
  },

  --tag at right
  {
    'liuchengxu/vista.vim',
    init = function()
      g.vista_icon_indent = {'└➜ ', '├➜ ' }

      g.vista_echo_cursor_strategy =  'echo'
      -- To enable fzf's preview window set g:vista_fzf_preview.
      -- The elements of g:vista_fzf_preview will be passed as arguments to fzf#vim#with_preview()
      -- For example:
      g.vista_fzf_preview = {'right:50%'}
      -- Ensure you have installed some decent font to show these pretty symbols, then you can enable icon for the kind.
      g['vista#renderer#enable_icon'] = 1

      g.vista_executive_for = {
        ['vimwiki'] = 'markdown',
        ['pandoc'] = 'markdown',
        ['markdown'] = 'toc',
        ['lua'] = 'nvim_lsp',
        ['sh'] = 'nvim_lsp',
        ['css'] = 'nvim_lsp',
        ['c'] = 'nvim_lsp',
        ['js'] = 'nvim_lsp',
        ['java'] = 'nvim_lsp'
      }
    end,
    config = function()
      vim.cmd("map <leader>tt <cmd>Vista!!<CR>")
    end
  },

  --statusline at bottom
  {
    'hoob3rt/lualine.nvim',
    after = 'tabline.nvim',
    config = function()
      local tabline = require'tabline'
      local gradle_status = require('lualine.components.gradle_status')

      require('lualine').setup({
        sections = {
          lualine_a = {'mode', 'asyncrun_status'},
          lualine_c = {'filename', 'lsp_progress'},
          lualine_y = {'progress',
            {
              'gradle_status',
              condition = gradle_status.isEnabled
            }
          },
          lualine_z = {
            {
              'diagnostics',
              sources = {'nvim_lsp'},
              sections = {'error', 'warn', 'info'}
            },
            'location'
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
          'fugitive', 'fzf', 'nerdtree'
        }
      })
    end
  },

  {
    'kyazdani42/nvim-web-devicons',
    config = function()
      require'nvim-web-devicons'.setup {
        -- your personnal icons can go here (to override)
        -- DevIcon will be appended to `name`
        override = {
          zsh = {
            icon = "",
            color = "#428850",
            name = "Zsh"
          }
        };
        -- globally enable default icons (default to false)
        -- will get overriden by `get_icons` option
        default = true;
      }
    end
  },

  {
    'folke/trouble.nvim',
    config = function()
      require("trouble").setup {
      }
    end
  },

  {
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup {
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
        hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ "}, -- hide mapping boilerplate
        show_help = true, -- show help message on the command line when the popup is visible
        triggers = {"<leader>", "<localleader>"}, -- or specify a list manually
        triggers_blacklist = {
          -- list of mode / prefixes that should never be hooked by WhichKey
          -- this is mostly relevant for key maps that start with a native binding
          -- most people should not need to change this
          i = { "j", "k" },
          v = { "j", "k" },
        },
      }
    end
  }
}

