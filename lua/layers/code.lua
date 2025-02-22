local vim = vim
local map = require("neospace").map

return {
  {
    "numToStr/Comment.nvim",
  },
  {
    "folke/todo-comments.nvim",
    dependencies = "nvim-lua/plenary.nvim",
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
  {
    "norcalli/nvim-colorizer.lua",
    opts = {}
  },

  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-nvim-lua",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-cmdline",
  "hrsh7th/cmp-emoji",
  "hrsh7th/cmp-nvim-lsp-signature-help",

  "rafamadriz/friendly-snippets",
  {
    "L3MON4D3/LuaSnip",
    build = function()
      os.execute("make install_jsregexp")
    end,
    config = function()
      local loadder = require("luasnip.loaders.from_snipmate")
      if vim.fn.isdirectory("~/.snippets") == 1 then
        loadder.lazy_load { path = "~/.snippets" }
      end
    end
  },
  "saadparwaiz1/cmp_luasnip",

  "ray-x/cmp-treesitter",

  "f3fora/cmp-spell",
  {
    "paopaol/cmp-doxygen",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-treesitter/nvim-treesitter-textobjects"
    }
  },

  {
    "hrsh7th/nvim-cmp",
    dependencies = {
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
        experimental = {
          ghost_text = {hlgroup = "Comment"}
        },
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = {
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
        sources = cmp.config.sources({
          { name = "codeium" },
          { name = "codecompanion" },
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
          { name = 'treesitter' },
        }),
        formatting = {
          format = lspkind.cmp_format({
            mode = 'symbol',
            maxwidth = 50,
            ellipsis_char = '...',
            symbol_map = {
              Codeium = "",
            }
          })
        }
      })

      cmp.setup.filetype("gitcommit", {
        sources = cmp.config.sources({
          { name = "cmp_git" },
          { name = "buffer" },
          { name = "spell" },
          { name = "emoji" },
        }),
      })

      cmp.setup.cmdline("/", {
        completion = { autocomplete = false },
        sources = {
          { name = "buffer", option = { keyword_pattern = [=[[^[:blank:]].*]=] } },
        },
      })

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
    "windwp/nvim-autopairs",
    dependencies = {
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
              }
            },
            tex = false
          }
        })
      )
      local npairs = require("nvim-autopairs")
      npairs.setup({
        check_ts = false,
        map_cr = true,
        map_complete = true,
        ts_config = {
          lua = { "string" },
          javascript = { "template_string" },
          java = false,
        },
      })
    end,
  },
  {
    "johmsalas/text-case.nvim",
    dependencies = "nvim-telescope/telescope.nvim",
    config = function()
      require("textcase").setup({})
      require("telescope").load_extension("textcase")
      map({ "n", "v" }, "ga.", "<cmd>TextCaseOpenTelescope<CR>", { desc = "Telescope" })
    end,
  },
  {
    "danymat/neogen",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = function()
      local neogen = require("neogen")
      neogen.setup({
        snippet_engine = "luasnip",
        placeholders_hl = "DiagnosticHint",
      })

      local generate = require('neogen').generate

      local wk = require("which-key")
      wk.add({
        { "<leader>n", group = "Neogen" },
        { "<leader>nF", function() generate{ type = 'file'} end, desc = "Neogen File" },
        { "<leader>nc", function() generate{ type = 'class'} end, desc = "Neogen Class" },
        { "<leader>nf", function() generate{ type = 'func'} end, desc = "Neogen Function" },
        { "<leader>ng", generate, desc = "Neogen Smart" },
        { "<leader>nt", function() generate{ type = 'type'} end, desc = "Neogen Type/Mod" },
      })
    end,
  },
  {
    "luckasRanarison/nvim-devdocs",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("nvim-devdocs").setup()
    end
  }
}
