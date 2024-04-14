local vim = vim

return {
  {
    "williamboman/mason.nvim",
    after = "neovim/nvim-lspconfig",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    after = "williamboman/mason.nvim",
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
  {
    "jay-babu/mason-null-ls.nvim",
    after = {
      "williamboman/mason.nvim",
      "nvimtools/none-ls.nvim",
    },
    config = function()
      require("mason-null-ls").setup({
          ensure_installed = nil,
          automatic_installation = true,
      })
    end,
  }
}
