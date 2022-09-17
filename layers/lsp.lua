local vim = vim

return {
  {
    "neovim/nvim-lspconfig",
  },
  {
    "williamboman/mason.nvim",
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
    "glepnir/lspsaga.nvim",
    after = "neovim/nvim-lspconfig",
    config = function()
      local saga = require("lspsaga")
      local opts = {}

      local function get_file_name(include_path)
        local file_name = require("lspsaga.symbolwinbar").get_file_name()
        if vim.fn.bufname("%") == "" then
          return ""
        end
        if include_path == false then
          return file_name
        end
        -- Else if include path: ./lsp/saga.lua -> lsp > saga.lua
        local sep = vim.loop.os_uname().sysname == "Windows" and "\\" or "/"
        local path_list = vim.split(string.gsub(vim.fn.expand("%:~:.:h"), "%%", ""), sep)
        local file_path = ""
        for _, cur in ipairs(path_list) do
          file_path = (cur == "." or cur == "~") and "" or file_path .. cur .. " " .. "%#LspSagaWinbarSep#>%*" .. " %*"
        end
        return file_path .. file_name
      end

      local function config_winbar()
        local exclude = {
          ["teminal"] = true,
          ["toggleterm"] = true,
          ["prompt"] = true,
          ["NvimTree"] = true,
          ["help"] = true,
        } -- Ignore float windows and exclude filetype
        if vim.api.nvim_win_get_config(0).zindex or exclude[vim.bo.filetype] then
          vim.wo.winbar = ""
        else
          local ok, lspsaga = pcall(require, "lspsaga.symbolwinbar")
          local sym
          if ok then
            sym = lspsaga.get_symbol_node()
          end
          local win_val = ""
          win_val = get_file_name(true) -- set to true to include path
          if sym ~= nil then
            win_val = win_val .. sym
          end
          vim.wo.winbar = win_val
        end
      end

      local events = { "BufEnter", "BufWinEnter", "CursorMoved" }

      vim.api.nvim_create_autocmd(events, {
        pattern = "*",
        callback = function()
          config_winbar()
        end,
      })

      vim.api.nvim_create_autocmd("User", {
        pattern = "LspsagaUpdateSymbol",
        callback = function()
          config_winbar()
        end,
      })

      opts.symbol_in_winbar = {
        in_custom = true,
        click_support = function(node, clicks, button, modifiers)
          -- To see all avaiable details: vim.pretty_print(node)
          local st = node.range.start
          local en = node.range["end"]
          if button == "l" then
            if clicks == 2 then
              -- double left click to do nothing
            else -- jump to node's starting line+char
              vim.fn.cursor(st.line + 1, st.character + 1)
            end
          elseif button == "r" then
            if modifiers == "s" then
              print("lspsaga") -- shift right click to print "lspsaga"
            end -- jump to node's ending line+char
            vim.fn.cursor(en.line + 1, en.character + 1)
          elseif button == "m" then
            -- middle click to visual select node
            vim.fn.cursor(st.line + 1, st.character + 1)
            vim.cmd("normal v")
            vim.fn.cursor(en.line + 1, en.character + 1)
          end
        end,
      }
      saga.init_lsp_saga(opts)
    end,
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    after = "nvim-lua/plenary.nvim",
    config = function()
      local null_ls = require("null-ls")
      null_ls.setup({
        debug = true
      })
    end,
  },
}
