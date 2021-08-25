
return {
  {
    'neovim/nvim-lspconfig',
  },
  {
    'kabouzeid/nvim-lspinstall',
    after = {"nvim-lspconfig"},
    config = function()
      vim.defer_fn(function()
        local setup_servers = require'neospace.lsp'.setup_servers

        require'lspinstall'.setup()

        setup_servers()

        -- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim
        require'lspinstall'.post_install_hook = function ()
          setup_servers() -- reload installed servers
          vim.cmd("bufdo e") -- this triggers the FileType autocmd that starts the server
        end
      end, 200)
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
