local vim = vim

return {
  {
    "williamboman/mason.nvim",
    dependencies = "neovim/nvim-lspconfig",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = "williamboman/mason.nvim",
    config = function()
      require("mason-lspconfig").setup({
        log_level = vim.log.levels.DEBUG,
      })

      require("mason-lspconfig").setup_handlers({
        function(server_name) -- default handler (optional)
          local lsp = require("neospace.lsp")
          local opts = lsp.setting(server_name)
          require("lspconfig")[server_name].setup(opts)
        end,
      })
    end,
  },
}
