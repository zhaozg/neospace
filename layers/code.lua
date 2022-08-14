local vim = vim
local g = vim.g
local map = require('neospace').map

return {
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  },
  {
    "folke/todo-comments.nvim",
    after = "nvim-lua/plenary.nvim",
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
      vim.opt.listchars:append("eol:↵")
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
      map('n', '<Leader>ti', '<cmd>IndentBlanklineToggle<CR>')
    end,
  },
  {
    "mhartington/formatter.nvim",
    config = function()
      local fmt = require("neospace.fmt")

      require("formatter").setup({
        filetype = {
          javascript = {
            function()
              return fmt.javascript
            end,
          },
          sh = {
            function()
              return fmt.sh
            end,
          },
          lua = {
            function()
              return fmt.lua
            end,
          },
          c = {
            function()
              return fmt.c
            end,
          },
          java = {
            function()
              return fmt.java
            end,
          },
          cpp = {
            function()
              return fmt.cpp
            end,
          },
        },
      })

      map({'n', 'x'}, '<Leader>xf', ':Format<CR>')
    end,
  },
  "wellle/targets.vim",
  {
    "AndrewRadev/splitjoin.vim",
    init = function()
      g.splitjoin_join_mapping = ""
      g.splitjoin_split_mapping = ""
    end,
    config = function()
      map('n', '<Leader>cJ', '<plug>SplitjoinJoin')
      map('n', '<Leader>cS', '<Plug>SplitjoinSplit')
    end,
  },
  "tpope/vim-sleuth",
  {
    "gpanders/editorconfig.nvim",
  },

  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup()
    end,
  },

  "sheerun/vim-polyglot",

  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-cmdline",
  "rafamadriz/friendly-snippets",
  "hrsh7th/vim-vsnip",
  "hrsh7th/cmp-vsnip",
  {
    "paopaol/cmp-doxygen",
    after = "nvim-treesitter/nvim-treesitter",
  },

  {
    "hrsh7th/nvim-cmp",
    config = function()
      local cmp = require("cmp")

      local has_words_before = function()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      local feedkey = function(key, mode)
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
      end

      cmp.setup({
        snippet = {
          expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
          end,
        },
        mapping = {
          -- Super-Tab like mapping
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif vim.fn["vsnip#available"](1) == 1 then
              feedkey("<Plug>(vsnip-expand-or-jump)", "")
            elseif has_words_before() then
              cmp.complete()
            else
              fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
            end
          end, { "i", "s" }),

          ["<S-Tab>"] = cmp.mapping(function()
            if cmp.visible() then
              cmp.select_prev_item()
            elseif vim.fn["vsnip#jumpable"](-1) == 1 then
              feedkey("<Plug>(vsnip-jump-prev)", "")
            end
          end, { "i", "s" }),
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
          { name = "doxygen" },
          { name = "nvim_lsp" },
          { name = 'vsnip' },
        }, {
          { name = "buffer" },
        }),
      })

      -- Set configuration for specific filetype.
      cmp.setup.filetype('gitcommit', {
        sources = cmp.config.sources({
          { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
        }, {
          { name = 'buffer' },
        })
      })

      -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline("/", {
        completion = { autocomplete = false },
        sources = {
          { name = "buffer", option = { keyword_pattern = [=[[^[:blank:]].*]=] } },
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
    "johmsalas/text-case.nvim",
    config = function()
      require("textcase").setup({})
      require("telescope").load_extension("textcase")
      map({'n', 'v'}, "ga.", "<cmd>TextCaseOpenTelescope<CR>", { desc = "Telescope" })
    end,
  },
  {
    "danymat/neogen",
    after = "nvim-treesitter/nvim-treesitter",
    config = function()
        require('neogen').setup {}
    end,
  }
}
