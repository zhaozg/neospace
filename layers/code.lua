local vim = _G.vim
local g = vim.g

--vim.cmd("nnoremap <SID>Man :Man <C-R><C-W><CR>")
--vim.cmd("nmap<Leader>hm <SID>Man")

return {
  {
    "preservim/nerdcommenter",
    init = function()
      g.NERDCreateDefaultMappings = 0
    end,
    config = function()
      vim.cmd("xmap <Leader>tS :UltiSnipsEdit<CR>")
      vim.cmd("nmap <Leader>tS :UltiSnipsEdit<CR>")
      vim.cmd("vmap <Leader>cZ  <Plug>NERDCommenterAltDelims")
      vim.cmd("vmap <Leader>cU  <Plug>NERDCommenterUncomment")
      vim.cmd("vmap <Leader>cL  <Plug>NERDCommenterAlignLeft")
      vim.cmd("vmap <Leader>cB  <Plug>NERDCommenterAlignBoth")
      vim.cmd("vmap <Leader>cM  <Plug>NERDCommenterMinimal")
      vim.cmd("vmap <Leader>cC  <Plug>NERDCommenterComment")
      vim.cmd("vmap <Leader>c<Space>  <Plug>NERDCommenterToggle")
      vim.cmd("vmap <Leader>cN  <Plug>NERDCommenterNested")
      vim.cmd("vmap <Leader>cI  <Plug>NERDCommenterInvert")
      vim.cmd("vmap <Leader>cA  <Plug>NERDCommenterAppend")
      vim.cmd("vmap <Leader>c$  <Plug>NERDCommenterToEOL")
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("indent_blankline").setup({
        char = "⋅",
        enabled = false,
        show_first_indent_level = false,
        show_end_of_line = true,
        show_current_context = true,
        buftype_exclude = { "terminal" },
        show_trailing_blankline_indent = true,
        char_highlight_list = {
          "IndentBlanklineIndent1",
          "IndentBlanklineIndent2",
        },
      })
      vim.cmd("nmap <silent> <Leader>ti <cmd>IndentBlanklineToggle<CR>")
    end,
  },
  {
    "mhartington/formatter.nvim",
    config = function()
      require("formatter").setup({
        filetype = {
          javascript = {
            -- prettier
            function()
              return {
                exe = "prettier",
                args = { "--stdin-filepath", vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)), "--single-quote" },
                stdin = true,
              }
            end,
          },
          sh = {
            -- Shell Script Formatter
            function()
              return {
                exe = "shfmt",
                args = { "-i", 2 },
                stdin = true,
              }
            end,
          },
          lua = {
            function()
              return {
                exe = "stylua",
                args = {
                  "--config-path " .. (os.getenv("XDG_CONFIG_HOME") or "~/.config") .. "/stylua/stylua.toml",
                  "-",
                },
                stdin = true,
              }
            end,
          },
          cpp = {
            -- clang-format
            function()
              return {
                exe = "clang-format",
                args = { "--assume-filename", vim.api.nvim_buf_get_name(0) },
                stdin = true,
                cwd = vim.fn.expand("%:p:h"),  -- Run clang-format in cwd of the file.
              }
            end,
          },
        },
      })

      vim.cmd("xmap <Leader>xf :Format<CR>")
      vim.cmd("nmap <Leader>xf :Format<CR>")
    end,
  },
  "unblevable/quick-scope",
  "wellle/targets.vim",
  {
    "AndrewRadev/splitjoin.vim",
    init = function()
      g.splitjoin_join_mapping = ""
      g.splitjoin_split_mapping = ""
    end,
    config = function()
      vim.cmd("nmap <Leader>cJ <plug>SplitjoinJoin")
      vim.cmd("nmap <Leader>cS <Plug>SplitjoinSplit")
    end,
  },
  "tpope/vim-sleuth",
  {
    "zhaozg/vim-printf",
    config = function()
      vim.cmd("nnoremap <Leader>cp :Printf<CR>")
    end,
  },
  {
    "editorconfig/editorconfig-vim",
    init = function()
      g.EditorConfig_exclude_patterns = { "fugitive://.*", "scp://.*" }
    end,
  },
  "sheerun/vim-polyglot",

  {
    "SirVer/ultisnips",
    init = function()
      g.UltiSnipsUsePythonVersion = 2
      g.UltiSnipsEditSplit = "context"
      --CR will do snips expad, look at package.vim
      g.UltiSnipsExpandTrigger = "<nop>"
      g.UltiSnipsJumpForwardTrigger = "<tab>"
      g.UltiSnipsJumpBackwardTrigger = "<S-tab>"
      if vim.fn.exists("g:UltiSnipsSnippetsDir") then
        g.UltiSnipsSnippetDirectories = { vim.fn.get(g, "UltiSnipsSnippetsDir"), "UltiSnips" }
      end
    end,
  },
  "honza/vim-snippets",
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup()
    end,
  },

  {
    "nvim-lua/completion-nvim",
    init = function()
      -- By default auto popup is enable, turn it off by
      g.completion_enable_auto_popup = 1

      --	Enable the auto insert parenthesis feature. completion-nvim will
      --	insert parenthesis when completing methods or functions.
      g.completion_enable_auto_paren = 1

      g.completion_enable_snippet = "UltiSnips"
      g.completion_enable_in_comment = 1
      g.completion_trigger_character = { ".", "::", "->" }

      --"c-n" : i_CTRL-N
      --"c-p" : i_CTRL-P
      --"cmd" : i_CTRL-X_CTRL-V
      --"defs": i_CTRL-X_CTRL-D
      --"dict": i_CTRL-X_CTRL-K
      --"file": i_CTRL-X_CTRL-F
      --"incl": i_CTRL-X_CTRL-I
      --"keyn": i_CTRL-X_CTRL-N
      --"keyp": i_CTRL-X_CTRL-P
      --"line": i_CTRL-X_CTRL-L
      --"spel": i_CTRL-X_s
      --"tags": i_CTRL-X_CTRL-]
      --"thes": i_CTRL-X_CTRL-T
      --"user": i_CTRL-X_CTRL-U

      g.completion_chain_complete_list = {
        default = {
          default = {
            { complete_items = { "lsp", "snippet", "ts", "buffer" } },
            { mode = "<c-p>" },
            { mode = "<c-n>" },
          },
          comment = {},
          string = {
            { complete_items = { "path", "buffer" } },
          },
        },
        markdown = {
          default = {
            { mode = "buffers" },
          },
        },
        comment = {},
      }
    end,
    config = function()
      vim.cmd('inoremap <expr> <Tab>   pumvisible() ? "<C-n>" : "<Tab>"')
      vim.cmd('inoremap <expr> <S-Tab> pumvisible() ? "<C-p>" : "<S-Tab>"')

      -- Set completeopt to have a better completion experience
      vim.o.completeopt = "menuone,noinsert,noselect"

      vim.cmd("imap <tab> <Plug>(completion_smart_tab)")
      vim.cmd("imap <s-tab> <Plug>(completion_smart_s_tab)")
      vim.defer_fn(function()
        vim.cmd("autocmd BufEnter * lua require'completion'.on_attach()")
      end, 100)
    end,
  },
  "steelsojka/completion-buffers",
  {
    "windwp/nvim-autopairs",
    config = function()
      local npairs = require("nvim-autopairs")
      npairs.setup({
        check_ts = false,
        map_cr = true, --  map <CR> on insert mode
        map_complete = true, -- it will auto insert `(` after select function or method item
        ts_config = {
          lua = { "string" }, -- it will not add pair on that treesitter node
          javascript = { "template_string" },
          java = false, -- don't check treesitter on java
        },
      })
      --look at https://github.com/windwp/nvim-autopairs/wiki/Endwise
      --npairs.add_rules(require('nvim-autopairs.rules.endwise-lua'))
    end,
  },
}
