local vim = vim
local g = vim.g

return {
  {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end,
  },
  {
    "folke/todo-comments.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("todo-comments").setup({
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      })
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    init = function()
      vim.opt.termguicolors = true
      vim.g.indent_blankline_use_treesitter = true
      vim.cmd([[highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine]])
      vim.cmd([[highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine]])
      vim.cmd([[highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine]])
      vim.cmd([[highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine]])
      vim.cmd([[highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine]])
      vim.cmd([[highlight IndentBlanklineIndent6 guifg=#C678DD gui=nocombine]])

      vim.opt.list = true
      vim.opt.listchars:append("space: ")
      vim.opt.listchars:append("eol:↴")
    end,
    config = function()
      require("indent_blankline").init()
      require("indent_blankline").setup({
        char = "┊",
        space_char_blankline = " ",
        enabled = false,
        show_first_indent_level = false,
        show_end_of_line = true,
        show_current_context = true,
        buftype_exclude = { "alpha" },
        show_trailing_blankline_indent = true,
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
          c = {
            -- clang-format
            function()
              return {
                exe = "astyle",
                stdin = true,
                cwd = vim.fn.expand("%:p:h"), -- Run clang-format in cwd of the file.
              }
            end,
          },
          java = {
            function()
              return {
                exe = "astyle",
                args = {'--mode=java', '--indent=spaces=4'},
                stdin = true,
                cwd = vim.fn.expand("%:p:h"), -- Run clang-format in cwd of the file.
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
                cwd = vim.fn.expand("%:p:h"), -- Run clang-format in cwd of the file.
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
    "gpanders/editorconfig.nvim"
  },

  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup()
    end,
  },

  "sheerun/vim-polyglot",

  "honza/vim-snippets",
  {
    "SirVer/ultisnips",
    after = "vim-snippets",
    init = function()
      g.UltiSnipsUsePythonVersion = 3
      g.UltiSnipsExpandTrigger = "<Plug>(ultisnips_expand)"
      g.UltiSnipsJumpForwardTrigger = "<Plug>(ultisnips_jump_forward)"
      g.UltiSnipsJumpBackwardTrigger = "<Plug>(ultisnips_jump_backward)"
      g.UltiSnipsListSnippets = "<c-x><c-s>"
      g.UltiSnipsRemoveSelectModeMappings = E06C75
      g.UltiSnipsEditSplit = "context"
      if vim.fn.exists("g:UltiSnipsSnippetsDir") then
        g.UltiSnipsSnippetDirectories = { vim.fn.get(g, "UltiSnipsSnippetsDir"), "UltiSnips" }
      end
    end,
  },

  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-cmdline",
  "quangnguyen30192/cmp-nvim-ultisnips",

  {
    "hrsh7th/nvim-cmp",
    init = function()
    end,
    config = function()
      local cmp = require("cmp")

      cmp.setup({
        snippet = {
          expand = function(args)
            vim.fn["UltiSnips#Anon"](args.body)
          end,
        },
        mapping = {
          ["<Tab>"] = cmp.mapping({
            c = function()
              if cmp.visible() then
                cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
              else
                cmp.complete()
              end
            end,
            i = function(fallback)
              if cmp.visible() then
                cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
              elseif vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
                vim.api.nvim_feedkeys(t("<Plug>(ultisnips_jump_forward)"), "m", true)
              else
                fallback()
              end
            end,
            s = function(fallback)
              if vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
                vim.api.nvim_feedkeys(t("<Plug>(ultisnips_jump_forward)"), "m", true)
              else
                fallback()
              end
            end,
          }),
          ["<S-Tab>"] = cmp.mapping({
            c = function()
              if cmp.visible() then
                cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
              else
                cmp.complete()
              end
            end,
            i = function(fallback)
              if cmp.visible() then
                cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
              elseif vim.fn["UltiSnips#CanJumpBackwards"]() == 1 then
                return vim.api.nvim_feedkeys(t("<Plug>(ultisnips_jump_backward)"), "m", true)
              else
                fallback()
              end
            end,
            s = function(fallback)
              if vim.fn["UltiSnips#CanJumpBackwards"]() == 1 then
                return vim.api.nvim_feedkeys(t("<Plug>(ultisnips_jump_backward)"), "m", true)
              else
                fallback()
              end
            end,
          }),
          ["<Down>"] = cmp.mapping(cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }), { "i" }),
          ["<Up>"] = cmp.mapping(cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }), { "i" }),
          ["<C-n>"] = cmp.mapping({
            c = function()
              if cmp.visible() then
                cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
              else
                vim.api.nvim_feedkeys(t("<Down>"), "n", true)
              end
            end,
            i = function(fallback)
              if cmp.visible() then
                cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
              else
                fallback()
              end
            end,
          }),
          ["<C-p>"] = cmp.mapping({
            c = function()
              if cmp.visible() then
                cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
              else
                vim.api.nvim_feedkeys(t("<Up>"), "n", true)
              end
            end,
            i = function(fallback)
              if cmp.visible() then
                cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
              else
                fallback()
              end
            end,
          }),
          ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
          ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
          ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
          ["<C-e>"] = cmp.mapping({ i = cmp.mapping.close(), c = cmp.mapping.close() }),
          ["<CR>"] = cmp.mapping({
            i = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
            c = function(fallback)
              if cmp.visible() then
                cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
              else
                fallback()
              end
            end,
          }),
        },
        -- ... Your other configuration ...
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "ultisnips" }, -- For ultisnips users.
        }, {
          { name = "buffer" },
        }),
      })

      -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline("/", {
        completion = { autocomplete = false },
        sources = {
          { name = 'buffer', option = { keyword_pattern = [=[[^[:blank:]].*]=] } }
        },
      })

      -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline(":", {
        completion = { autocomplete = false },
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          { name = "cmdline" },
        }),
      })

      -- Setup lspconfig.
      --[[
      local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
      -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
      require('lspconfig')['<YOUR_LSP_SERVER>'].setup {
        capabilities = capabilities
      }
      --]]

      -- Set completeopt to have a better completion experience
      vim.o.completeopt = "menuone,noinsert,noselect"
    end,
  },

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
  {
    "glepnir/lspsaga.nvim",
    init = function()
      vim.cmd([[
      "-- lsp provider to find the cursor word definition and reference
      nnoremap <silent> gh :Lspsaga lsp_finder<CR>

      "-- code action
      nnoremap <silent><leader>ca :Lspsaga code_action<CR>
      vnoremap <silent><leader>ca :<C-U>Lspsaga range_code_action<CR>

      "-- show hover doc
      nnoremap <silent>K :Lspsaga hover_doc<CR>

      "-- scroll down hover doc or scroll in definition preview
      nnoremap <silent> <C-f> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>
      "- scroll up hover doc
      nnoremap <silent> <C-b> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>

      "-- show signature help
      nnoremap <silent> gs :Lspsaga signature_help<CR>

      "-- rename
      nnoremap <silent>gr :Lspsaga rename<CR>

      "-- preview definition
      nnoremap <silent> gd :Lspsaga preview_definition<CR>

      "-- Jump Diagnostic and Show Diagnostics
      "-- show
      nnoremap <silent> <leader>cd :Lspsaga show_line_diagnostics<CR>

      "-- only show diagnostic if cursor is over the area
      nnoremap <silent><leader>cc <cmd>lua require'lspsaga.diagnostic'.show_cursor_diagnostics()<CR>

      "-- jump diagnostic
      nnoremap <silent> [e :Lspsaga diagnostic_jump_next<CR>
      nnoremap <silent> ]e :Lspsaga diagnostic_jump_prev<CR>
      ]])

    end,
    config = function()
      local saga = require 'lspsaga'
      saga.init_lsp_saga({
        -- add your config value here
        -- default value
        -- use_saga_diagnostic_sign = true
        -- error_sign = '',
        -- warn_sign = '',
        -- hint_sign = '',
        -- infor_sign = '',
        -- dianostic_header_icon = '   ',
        -- code_action_icon = ' ',
        -- code_action_prompt = {
        --   enable = true,
        --   sign = true,
        --   sign_priority = 20,
        --   virtual_text = true,
        -- },
        -- finder_definition_icon = '  ',
        -- finder_reference_icon = '  ',
        -- max_preview_lines = 10, -- preview lines of lsp_finder and definition preview
        -- finder_action_keys = {
        --   open = 'o', vsplit = 's',split = 'i',quit = 'q',scroll_down = '<C-f>', scroll_up = '<C-b>' -- quit can be a table
        -- },
        -- code_action_keys = {
        --   quit = 'q',exec = '<CR>'
        -- },
        -- rename_action_keys = {
        --   quit = '<C-c>',exec = '<CR>'  -- quit can be a table
        -- },
        -- definition_preview_icon = '  '
        -- "single" "double" "round" "plus"
        -- border_style = "single"
        -- rename_prompt_prefix = '➤',
        -- if you don't use nvim-lspconfig you must pass your server name and
        -- the related filetypes into this table
        -- like server_filetype_map = {metals = {'sbt', 'scala'}}
        -- server_filetype_map = {}
      })
    end
 }
}
