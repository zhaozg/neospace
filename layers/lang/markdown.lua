local vim = vim
local g = vim.g
local lang = require('neospace.lang')

return {
  {
    "ekickx/clipboard-image.nvim",
    ft = { "markdown", "telekasten" },
    config = function()
      require 'clipboard-image'.setup {
        telekasten = {
          affix = "![](%s)"
        }
      }
      vim.keymap.set('i', "<C-p>", "<ESC>:PasteImg<CR>")
      vim.keymap.set('n', "<C-p>", ":PasteImg<CR>")
    end
  },
  {
    "kvrohit/tasks.nvim",
    config = function()
      local wk = require("which-key")
      wk.register({
        t = { ":ToggleTask<CR>", "ToggleTask" },
        x = { ":CancelTask<CR>", "CancelTask" },
        u = { ":UndoTask<CR>", "UndoTask" },
      }, { prefix = "<localleader>" })
    end,
  },
  {
    "iamcco/markdown-preview.nvim",
    install = { "sh", "-c", "cd app && yarn install" },
    init = function()
      g.mkdp_preview_options = {
        disable_sync_scroll = 0,
        hide_yaml_meta = 1,
        sequence_diagrams = {
          theme = "simple",
        },
        flowchart_diagrams = {
          x = 0,
          y = 0,
          ["line-width"] = 2,
          ["line-length"] = 15,
          ["text-margin"] = 10,
          ["font-size"] = 14,
          ["font-color"] = "black",
          ["line-color"] = "black",
          ["element-color"] = "black",
          ["yes-text"] = "yes",
          ["no-text"] = "no",
          ["arrow-end"] = "block",
          fill = "white",
          symbols = {
            start = {},
            ["end"] = {},
            condition = { ["text-margin"] = 0.5 },
            inputoutput = {},
            operation = {},
            subroutine = {},
            parallel = {},
          },
        },
        ["content_editable"] = false,
      }

      g.mkdp_page_title = "${name}"

      g.vim_markdown_fenced_languages = {
        "csharp=cs",
        "c++=cpp",
        "viml=vim",
        "bash=sh",
        "ini=dosini",
        "flowchart=flow",
        "chart=json",
        "sequence-diagrams=sequence",
      }
    end,
    config = function()
      local _, wk = pcall(require, "which-key")
      if _ then
        wk.register({
          p = { "<Plug>MarkdownPreview<CR>", "MarkdownPreview" },
          s = { "<Plug>MarkdownPreviewStop<CR>", "MarkdownPreviewStop" },
          f = { "<Plug>(EasyAlign)ip*|", "TableFormat" },
        }, { prefix = "<localleader>" })
      end
    end,
  },
  {
    "ellisonleao/glow.nvim",
    init = function()
      vim.g.glow_binary_path = "/usr/local/bin"
      vim.g.glow_use_pager = true
    end,
  },
  "renerocksai/calendar-vim",
  {
    "renerocksai/telekasten.nvim",
    after = "renerocksai/calendar-vim",
    config = function()
      local home = vim.fn.expand("~/Documents/Notes")
      require("telekasten").setup({
        home = home,
        take_over_my_home = true,
        auto_set_filetype = true,

        dailies = home .. "/" .. "daily",
        weeklies = home .. "/" .. "weekly",
        templates = home .. "/" .. "templates",

        image_subdir = "img",

        extension = ".md",

        new_note_filename = "title",
        uuid_type = "%Y%m%d%H%M",
        uuid_sep = "-",

        follow_creates_nonexisting = true,
        dailies_create_nonexisting = true,
        weeklies_create_nonexisting = true,

        journal_auto_open = false,

        template_new_note = home .. "/" .. "templates/new_note.md",
        template_new_daily = home .. "/" .. "templates/daily.md",
        template_new_weekly = home .. "/" .. "templates/weekly.md",

        image_link_style = "markdown",
        sort = "filename",
        plug_into_calendar = true,
        calendar_opts = {
          -- calendar week display mode: 1 .. 'WK01', 2 .. 'WK 1', 3 .. 'KW01', 4 .. 'KW 1', 5 .. '1'
          weeknm = 4,
          -- use monday as first day of week: 1 .. true, 0 .. false
          calendar_monday = 1,
          -- calendar mark: where to put mark for marked days: 'left', 'right', 'left-fit'
          calendar_mark = "left-fit",
        },

        -- telescope actions behavior
        close_after_yanking = false,
        insert_after_inserting = true,

        -- tag notation: '#tag', ':tag:', 'yaml-bare'
        tag_notation = "#tag",

        -- command palette theme: dropdown (window) or ivy (bottom panel)
        command_palette_theme = "ivy",

        -- tag list theme:
        -- get_cursor: small tag list at cursor; ivy and dropdown like above
        show_tags_theme = "ivy",

        -- when linking to a note in subdir/, create a [[subdir/title]] link
        -- instead of a [[title only]] link
        subdirs_in_links = true,
        template_handling = "smart",
        new_note_location = "smart",
        rename_update_links = true,
      })
    end,
  },
  {
    "mickael-menu/zk-nvim",
    config = function()
      require("zk").setup()
    end
  },
  {
    "aspeddro/pandoc.nvim",
    ft = { "markdown", "telekasten" },
    config = function()
      local init = {
        { "--toc" },
        { "--standalone" },
        { "--from", "gfm" },
      }
      if lang.markdown.pandoc.render.css then
        init[#init + 1] = { "--css", lang.markdown.pandoc.render.css }
      end
      require 'pandoc'.setup({
        default = {
          output = '%s.html',
          args = {
            { "--toc" },
            { "--standalone" }
          }
        },
        mappings = {
          -- normal mode
          n = {
            ['<localleader>eh'] = function()
              local function output()
                local bufname = vim.api.nvim_buf_get_name(0)
                return ("%s.html"):format(bufname:gsub(".[^.]+$", ""))
              end

              require('pandoc.render').file(
                vim.tbl_extend("force", init, {
                  { "--self-contained" },
                  { "--output", output() }
                })
              )
            end,
            ['<localleader>ep'] = function()
              local function output()
                local bufname = vim.api.nvim_buf_get_name(0)
                return ("%s.pdf"):format(bufname:gsub(".[^.]+$", ""))
              end

              require('pandoc.render').file(
                vim.tbl_extend("force", init, {
                  { "--pdf-engine", "prince" },
                  { "--output", output() }
                })
              )
            end,

          }
        }
      })
    end
  },
  {
    "hotoo/pangu.vim",
    ft = { "markdown", "telekasten" },
  },
}
