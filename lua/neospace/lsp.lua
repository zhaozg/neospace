local vim = vim

local map = require("neospace").map

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  require("lsp-status").on_attach(client, bufnr)
  require("lsp-format").on_attach(client, bufnr)
  require("lsp_signature").on_attach(client, bufnr)

  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  map(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>")
  map(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>")
  map(bufnr, "n", "cD", "<cmd>lua vim.lsp.buf.type_definition()<CR>")
  map(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>")
  map(bufnr, "n", "gf", "<cmd>lua vim.lsp.buf.formatting()<CR>")
  map(bufnr, "n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>")
  map(bufnr, "n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>")
  map(bufnr, "n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>")

  if not vim.fn.exists(":Lspsaga") then
    map(bufnr, "n", "cd", "<cmd>lua vim.lsp.buf.definition()<CR>")

    map(bufnr, "n", "gh", "<cmd>lua vim.lsp.buf.hover()<CR>")
    map(bufnr, "n", "ga", "<cmd>lua vim.lsp.buf.code_action()<CR>")
    map(bufnr, "n", "ch", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
    map(bufnr, "n", "cr", "<cmd>lua vim.lsp.buf.rename()<CR>")

    -- See `:help vim.diagnostic.*` for documentation on any of the below functions
    map(bufnr, "n", "ge", "<cmd>lua vim.diagnostic.open_float()<CR>")
    map(bufnr, "n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>")
    map(bufnr, "n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>")
    map(bufnr, "n", "gq", "<cmd>lua vim.diagnostic.setloclist()<CR>")
  else
    map(bufnr, "n", "cd", "<cmd>Lspsaga preview_definition<CR>")
    map(bufnr, "n", "gh", "<cmd>Lspsaga hover_doc<CR>")
    map(bufnr, "n", "ga", "<cmd>Lspsaga code_action<CR>")
    map(bufnr, "v", "ga", "<cmd><C-U>Lspsaga range_code_action<CR>")
    map(bufnr, "n", "ch", "<cmd>Lspsaga signature_help<CR>")
    map(bufnr, "n", "cr", "<cmd>Lspsaga rename<CR>")

    map(bufnr, "n", "ge", "<cmd>Lspsaga show_line_diagnostics<cr>")
    map(bufnr, "n", "ge", "<cmd>Lspsaga show_cursor_diagnostics<cr>")
    map(bufnr, "n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<cr>")
    map(bufnr, "n", "]e", "<cmd>Lspsaga diagnostic_jump_next<cr>")

    map(bufnr, "n", "gF", "<cmd>Lspsaga lsp_finder<CR>")
    -- scroll up hover doc
    map(bufnr, "n", "<C-b>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1, '<c-b>')<cr>")
    -- scroll down hover doc or scroll in definition preview
    map(bufnr, "n", "<C-f>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1, '<c-f>')<cr>")
  end
end

-- config that activates keymaps and enables snippet support
local function make_config()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  return {
    -- enable snippet support
    capabilities = capabilities,
    -- map buffer local keybindings when the language server attaches
    on_attach = on_attach,
  }
end

-- real settings in private layers
local settings = {}

return {
  settings = settings,
  setting = function(name, options)
    local config = make_config()

    options = options or {}
    settings[name] = settings[name] or {}

    settings[name] = vim.tbl_extend("force", settings[name], options)

    return vim.tbl_extend("force", config, settings[name])
  end,
}
