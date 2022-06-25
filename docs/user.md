# USER

User is a fork of [user.nvim](https://github.com/faerryn/user.nvim) and [plogins.nvim](https://github.com/faerryn/plogins.nvim) packman for neovim, but update largely.


+  repo_base = "http://git.what996.com/"

## Howto use

* `:PluginsUpgrade` will update all plugins.
* `:PluginsPluginsAutoremove` will remove all plugins.
* Auto install new plugins.

## Requirements
- [Neovim 0.5.0](https://neovim.io/)
- [Git](https://git-scm.com/)

## Recommendations

Neovim 0.5.0 now supports using init.lua, where lua code can be put.
If you have a init.vim or .vimrc, you can put your lua code in a heredoc block:

```
lua << EOF
-- lua code goes here
EOF
```

## Usage
setup(): Mandatory to make the lua work:
```lua
local plugins = {
  "tpope/vim-commentary",
  {"tpope/vim-repeat"},

  {
    "tpope/vim-fugitive",
    config=function()
      vim.api.nvim_set_keymap("n", "<leader>g", "<cmd>Git<CR>", opts)
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    config = function()
        require("nvim-treesitter.configs").setup {
            ensure_installed = "all",
            highlight = { enable = true },
            indent = { enable = true },
        }
        vim.opt.foldmethod = "expr"
        vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
    end,
    install = function()
        require("nvim-treesitter.install").update()
    end,
 },

 {"nvim-treesitter-textobjects",

  after  = { "nvim-treesitter/nvim-treesitter" },
  config = function()
    require'nvim-treesitter.configs'.setup {
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
    }
    end
  }
}

local user = require("user")
user.setup(plugins, {
  repo_base = "http://git.what996.com/"  -- default is "https://github.com/"
})

```

```lua
local use = require('user').use
use {
	"package_author/package_name",
	repo = nil, -- if non-nil, then clone from this repo instead
	branch = nil, -- if non-nil, then clone from this branch instead of default branch
	subdir = nil, -- if non-nil, then will add that subdirectory to rtp
	init = function()
		-- will run immediately unless disabled = true.
	end,
	config = function()
		-- will run after the package is loaded. not very useful if you don't have `parallel` enabled.
	end,
}
```
