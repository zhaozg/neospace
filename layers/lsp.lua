local vim = vim

return {
  {
    'neovim/nvim-lspconfig',
  },
  {
    'williamboman/nvim-lsp-installer',
    after = {"nvim-lspconfig"},
    config = function()
      local lsp_installer = require("nvim-lsp-installer")
      -- Provide settings first!
      lsp_installer.settings {
          ui = {
              icons = {
                  server_installed = "✓",
                  server_pending = "➜",
                  server_uninstalled = "✗"
              }
          },
          log_level = vim.log.levels.ERROR,
      }

      local lsp = require('neospace.lsp')

      lsp_installer.on_server_ready(function(server)
          local opts = lsp.setting(server.name)
          server:setup(opts)
          vim.cmd [[ do User LspAttachBuffers ]]
      end)
    end
  },
  {
    'nvim-lua/lsp-status.nvim',
  },
  {
    'ojroques/nvim-lspfuzzy',
    config = function()
      require('lspfuzzy').setup {}
    end
  },
  {
    "tami5/lspsaga.nvim",
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
        use_saga_diagnostic_sign = false,
        -- add your config value here
        -- default value
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
