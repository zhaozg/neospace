local vim = vim
local fn = vim.fn -- to call Vim functions e.g. fn.bufnr()
local o = vim.o

local fun = require("neospace.fun")
local neospace = require("neospace")

return  {
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
    "MunifTanjim/nui.nvim",
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
        return string.format(
          "v%d.%d.%d%s",
          t.major,
          t.minor,
          t.patch,
          t.api_prerelease and "-dev" or ""
        )
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
  {
    "luukvbaal/statuscol.nvim",
    after = "kevinhwang91/promise-async",
    config = function()
      local builtin = require("statuscol.builtin")
      require("statuscol").setup({
        relculright = true,
        segments = {
          { text = { builtin.foldfunc }, click = "v:lua.ScFa" },
          { text = { "%s" }, click = "v:lua.ScSa" },
          { text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
        },
      })
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
        view = {
          -- width of the window, can be either a number (columns) or a string in `%`, for left or right side placement
          width = 30,
          -- side of the tree, can be one of 'left' | 'right' | 'top' | 'bottom'
          side = "left",
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
      require("neospace").map("", "<leader>tf", "<cmd>NvimTreeToggle<CR>")
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
      local wk = require("which-key")
      wk.register({
        a = { name = "align" },
        b = { name = "buffer" },
        c = { name = "code" },
        d = { name = "debug" },
        f = { name = "find" },
        g = { name = "git" },
        t = { name = "toggle" },
        w = { name = "windows" },
        x = { name = "text" },
        z = { name = "fold" },
      }, { prefix = "<leader>" })
      wk.setup({
        plugins = {
          spelling = {
            enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
            suggestions = 20, -- how many suggestions should be shown in the list?
          },
        },
        key_labels = {
          ["<space>"] = "SPC",
          ["<cr>"] = "RET",
          ["<tab>"] = "TAB",
        },
        ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
      })
    end,
  },

  {
    "lewis6991/satellite.nvim",
    config = function()
      require("satellite").setup({})
    end,
  },

  {
    "rcarriga/nvim-notify",
    config = function()
      require("notify").setup({
        timeout = 2000,
        top_down = false
      })
    end
  },
  {
    "folke/noice.nvim",
    after = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify"
    },
    config = function()
      require("noice").setup({
        lsp = {
          -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
          },
          signature = {
            enabled = false,
          },
        },
        -- you can enable a preset for easier configuration
        presets = {
          bottom_search = true, -- use a classic bottom cmdline for search
          command_palette = true, -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = false, -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = false, -- add a border to hover docs and signature help
        },
      })
    end,
  }
}

