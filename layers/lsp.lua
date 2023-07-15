local vim = vim

return {
  {
    "neovim/nvim-lspconfig",
  },
  {
    "nvim-lua/lsp-status.nvim",
    after = "neovim/nvim-lspconfig",
    config = function()
      require("lsp-status").config({
        status_symbol = "ʂ",
      })
    end,
  },
  {
    "ray-x/lsp_signature.nvim",
    after = "neovim/nvim-lspconfig",
  },
  {
    "nvimdev/lspsaga.nvim",
    after = {
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter"
    },
    config = function()
      local saga = require("lspsaga")
      local opts = {}

      local function config_winbar()
        local exclude = {
          teminal = true,
          toggleterm = true,
          prompt = true,
          NvimTree = true,
          help = true,
        } -- Ignore float windows and exclude filetype
        if vim.api.nvim_win_get_config(0).zindex or exclude[vim.bo.filetype] then
          vim.wo.winbar = ""
        else
          vim.wo.winbar = require("lspsaga.symbol.winbar"):get_bar()
        end
      end

      local events = { "BufEnter", "BufWinEnter", "CursorMoved" }

      vim.api.nvim_create_autocmd(events, {
        pattern = "*",
        callback = function()
          config_winbar()
        end,
      })

      opts.symbol_in_winbar = {
        enable = true
      }
      saga.setup(opts)
    end,
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    after = "nvim-lua/plenary.nvim",
    config = function()
      local null_ls = require("null-ls")
      null_ls.setup()
    end
  },
}
