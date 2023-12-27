local vim = vim
local g = vim.g
local lang = require('neospace.lang')

local layer = require("neospace.layer")
layer:append("nvimtools/none-ls.nvim", function()
  local null_ls = require "null-ls"
  local markdownlint = null_ls.builtins.diagnostics.markdownlint.with {
    extra_args = { "--config", "~/.markdownlint.yaml" }
  }
  null_ls.register(markdownlint)

  if vim.fn.executable("lint-md") == 1 then
    local helpers = require("null-ls.helpers")

    local lint_md_source = {
      name = "lint-md",
      method = null_ls.methods.DIAGNOSTICS,
      filetypes = { "markdown" },
      generator = helpers.generator_factory({
        command = "lint-md",
        args = { "$FILENAME" },
        from_stderr = false,
        from_stdout = true,
        format = "line",
        output = 'raw',
        use_cache = false,
        prepend_extra_args = true,
        multiple_files = false,
        timeout = 1000,
        to_temp_file = true,
        check_exit_code = function(code, stderr)
          local success = code <= 1

          if not success then print(stderr) end

          return true
        end,

        -- 28:1  error  代码语言不能为空，请在代码块语法上增加语言  no-empty-code-lang
        on_output = helpers.diagnostics.from_patterns({
          {
            pattern = [[(%d+):(%d+)%s+(%w+)%s+(.+)%s+(.*)]],
            groups = { "row", "col", "severity", "message", "code" },
          }
        })
      })
    }

    local fmt_md_source = {
      name = "lint-md",
      method = null_ls.methods.FORMATTING,
      filetypes = { "markdown" },
      generator = helpers.formatter_factory({
        command = "lint-md",
        args = { "--fix", "$FILENAME" },
        to_stdin = false,
        from_stderr = false,
        from_stdout = false,
        output = 'raw',
        use_cache = false,
        prepend_extra_args = true,
        multiple_files = false,
        from_temp_file = true,
        to_temp_file = true,
        timeout = 1000,
        check_exit_code = function(code, stderr)
          local success = code <= 1

          if not success then print(stderr) end

          return success
        end
      })
    }

    null_ls.register({
      null_ls.builtins.formatting.prettier,
      lint_md_source,
      fmt_md_source
    })
  end
end)

return {
  {
    "ekickx/clipboard-image.nvim",
    ft = { "markdown" },
    config = function()
      require 'clipboard-image'.setup {
        markdown = {
          img_dir = { "%:p:h", "img" },
          affix = "![](%s)",
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
      g.mkdp_auto_close = 0
      g.mkdp_refresh_slow = 1
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
    ft = "markdown",
    config = function()
      require('glow').setup({
        install_path = "/usr/local/bin",
        pager = true,
        -- your override config
      })
    end
  },
  {
    "mickael-menu/zk-nvim",
    after = "nvim-telescope/telescope.nvim",
    config = function()
      require("zk").setup()
      require("telescope").load_extension("zk")
    end
  },
  {
    "aspeddro/pandoc.nvim",
    ft = { "markdown" },
    config = function()
      local init = {
      }
      local function output(kind)
        kind = kind or 'html'
        local bufname = vim.api.nvim_buf_get_name(0)
        return ("%s." .. kind):format(bufname:gsub(".[^.]+$", ""))
      end

      require 'pandoc'.setup({
        default = {
          output = '%s.html',
          args = {
            { "--from",      "gfm" },
            { "--standalone" }
          }
        },
        mappings = {
          -- normal mode
          n = {
            ['<localleader>eh'] = function()
              local html_init = vim.tbl_extend('keep', init, {})
              if lang.markdown.pandoc.render.css then
                html_init[#html_init + 1] = { "--css", lang.markdown.pandoc.render.css }
              end
              require('pandoc.render').file(
                vim.tbl_extend("force", html_init, {
                  { "--toc" },
                  { "--standalone" },
                  { "--self-contained" },
                  { "--from",          "gfm" },
                  { "--output",        output('html') }
                })
              )
            end,

            ['<localleader>ep'] = function()
              local pdf_init = vim.tbl_extend('keep', init, {})
              if lang.markdown.pandoc.render.css then
                pdf_init[#pdf_init + 1] = { "--css", lang.markdown.pandoc.render.css }
              end
              require('pandoc.render').file(
                vim.tbl_extend("force", pdf_init, {
                  { "--toc" },
                  { "--standalone" },
                  { "--from",       "gfm" },
                  { "--pdf-engine", "prince" },
                  { "--output",     output('pdf') }
                })
              )
            end,
            ['<localleader>ed'] = function()
              local docx_init = vim.tbl_extend('keep', init, {})
              if lang.markdown.pandoc.render.referernce then
                docx_init[#docx_init + 1] = { "--referernce-doc", lang.markdown.pandoc.render.referernce }
              end

              require('pandoc.render').file(
                vim.tbl_extend("force", docx_init, {
                  { "--output", output('docx') }
                })
              )
            end,
          }
        }
      })
    end
  },
  {
    "jakewvincent/mkdnflow.nvim",
    ft = "markdown",
    config = function()
      require('mkdnflow').setup()
    end
  },
}
