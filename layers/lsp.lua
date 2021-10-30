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

      lsp_installer.on_server_ready(function(server)
          local opts = {}

          -- (optional) Customize the options passed to the server
          -- if server.name == "tsserver" then
          --     opts.root_dir = function() ... end
          -- end

          -- This setup() function is exactly the same as lspconfig's setup function (:help lspconfig-quickstart)
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
