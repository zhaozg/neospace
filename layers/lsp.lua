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
  }
}
