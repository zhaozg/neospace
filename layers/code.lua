
local vim = vim
local g = vim.g
local map = require("neospace").map

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
      vim.opt.list = true
      vim.opt.listchars:append("space: ")
      vim.opt.listchars:append("eol:↵")
    end,
    config = function()
      require("ibl").setup ({
        indent = {
          char = "┊"
        },
        exclude = {
          buftypes = {"alpha"}
        },
      })
      map("n", "<Leader>ti", "<cmd>IndentBlanklineToggle<CR>")
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
      map("n", "<Leader>cJ", "<plug>SplitjoinJoin")
      map("n", "<Leader>cS", "<Plug>SplitjoinSplit")
    end,
  },
  "tpope/vim-sleuth",
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup()
    end,
  },

  "sheerun/vim-polyglot",

  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-nvim-lua",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-cmdline",
  "hrsh7th/cmp-emoji",
  "hrsh7th/cmp-nvim-lsp-signature-help",

  "L3MON4D3/LuaSnip",
  "saadparwaiz1/cmp_luasnip",

  "f3fora/cmp-spell",
  {
    "paopaol/cmp-doxygen",
    after = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-treesitter/nvim-treesitter-textobjects"
    }
  },

  {
    "zbirenbaum/copilot-cmp",  -- need "zbirenbaum/copilot.lua"
    config = function ()
      require("copilot_cmp").setup()
    end
  },

  {
    "hrsh7th/nvim-cmp",
    after = {
      "L3MON4D3/LuaSnip",
      "onsails/lspkind.nvim"
    },
    init = function()
      vim.opt.spell = true
      vim.opt.spelllang = { "en_us", "cjk" }

      vim.o.completeopt = "menu,menuone,noselect"
    end,
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      local lspkind = require('lspkind')
      require("luasnip.loaders.from_vscode").lazy_load()
      require("luasnip.loaders.from_snipmate").lazy_load()
      require('neospace.cmp').active()

      local has_words_before = function()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = {
          -- Super-Tab like mapping
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<Down>"] = cmp.mapping(cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }), { "i" }),
          ["<Up>"] = cmp.mapping(cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }), { "i" }),
          ["<C-n>"] = cmp.mapping({
            c = function()
              if cmp.visible() then
                cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
              else
                vim.api.nvim_feedkeys("<Down>", "n", true)
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
                vim.api.nvim_feedkeys("<Up>", "n", true)
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
          { name = 'nvim_lua' },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "doxygen" },
          { name = "spell" },
          { name = "emoji" },
          { name = 'nvim_lsp_signature_help' },

          { name = "buffer" },
          { name = "path" },

          { name = "copilot", group_index = 2 },
          { name = "codeium" }
        }),
        formatting = {
          format = lspkind.cmp_format({
            mode = 'symbol', -- show only symbol annotations
            maxwidth = 50,   -- prevent the popup from showing more than provided characters
                             -- (e.g 50 will not show more than 50 characters)
            ellipsis_char = '...', -- when popup menu exceed maxwidth,
                                   -- the truncated part would show ellipsis_char instead
                                   -- (must define maxwidth first)
          })
        }
      })

      -- Set configuration for specific filetype.
      cmp.setup.filetype("gitcommit", {
        sources = cmp.config.sources({
          { name = "cmp_git" }, -- You can specify the `cmp_git` source if you were installed it.
          { name = "buffer" },
          { name = "spell" },
          { name = "emoji" },
        }),
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
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "cmdline" },
          { name = "cmdline_history" },
          { name = "path" },
          { name = "neospace" },
        }),
      })
    end,
  },

  {
    "paopaol/cmp-doxygen",
    after = {
      "hrsh7th/nvim-cmp",
      "nvim-treesitter/nvim-treesitter",
      "nvim-treesitter/nvim-treesitter-textobjects"
    }
  },

  {
    "windwp/nvim-autopairs",
    after = {
      "hrsh7th/nvim-cmp",
    },
    config = function()
      local cmp_autopairs = require('nvim-autopairs.completion.cmp')
      local handlers = require('nvim-autopairs.completion.handlers')
      local cmp = require('cmp')
      cmp.event:on(
        'confirm_done',
        cmp_autopairs.on_confirm_done({
          filetypes = {
            -- "*" is a alias to all filetypes
            ["*"] = {
              ["("] = {
                kind = {
                  cmp.lsp.CompletionItemKind.Function,
                  cmp.lsp.CompletionItemKind.Method,
                },
                handler = handlers["*"]
              }
            },
            lua = {
              ["("] = {
                kind = {
                  cmp.lsp.CompletionItemKind.Function,
                  cmp.lsp.CompletionItemKind.Method
                },
                -- @param char string
                -- @param item table item completion
                -- @param bufnr number buffer number
                -- @param rules table
                -- @param commit_character table<string>
                -- handler = function(char, item, bufnr, rules, commit_character)
                --   -- Your handler function. Inpect with print(vim.inspect{char, item, bufnr, rules, commit_character})
                -- end
              }
            },
            -- Disable for tex
            tex = false
          }
        })
      )
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
    after = "nvim-telescope/telescope.nvim",
    config = function()
      require("textcase").setup({})
      require("telescope").load_extension("textcase")
      map({ "n", "v" }, "ga.", "<cmd>TextCaseOpenTelescope<CR>", { desc = "Telescope" })
    end,
  },
  {
    "danymat/neogen",
    after = "nvim-treesitter/nvim-treesitter",
    config = function()
      local neogen = require("neogen")
      neogen.setup({
        snippet_engine = "luasnip",
        placeholders_hl = "DiagnosticHint",
      })

      local opts = { noremap = true, silent = true }
      vim.api.nvim_set_keymap("n", "<Leader>ng", ":lua require('neogen').generate()<CR>", opts)
      vim.api.nvim_set_keymap("n", "<Leader>nf", ":lua require('neogen').generate({ type = 'func' })<CR>", opts)
      vim.api.nvim_set_keymap("n", "<Leader>nF", ":lua require('neogen').generate({ type = 'file' })<CR>", opts)
      vim.api.nvim_set_keymap("n", "<Leader>nt", ":lua require('neogen').generate({ type = 'type' })<CR>", opts)
      vim.api.nvim_set_keymap("n", "<Leader>nc", ":lua require('neogen').generate({ type = 'class' })<CR>", opts)
    end,
  },
}
