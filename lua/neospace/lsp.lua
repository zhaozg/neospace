local vim = vim

local map = vim.api.nvim_buf_set_keymap
local opts = { noremap = true, silent = true }

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  require("lsp-status").on_attach(client)

  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  map(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  map(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  map(bufnr, "n", "cD", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
  map(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  map(bufnr, "n", "gf", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  map(bufnr, "n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
  map(bufnr, "n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
  map(bufnr, "n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)

  if not vim.fn.exists(":Lspsaga") then
    map(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)

    map(bufnr, "n", "gh", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
    map(bufnr, "n", "ga", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
    map(bufnr, "n", "ch", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
    map(bufnr, "n", "cr", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)

    -- See `:help vim.diagnostic.*` for documentation on any of the below functions
    map(bufnr, "n", "ge", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
    map(bufnr, "n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
    map(bufnr, "n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
    map(bufnr, "n", "gq", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
  else
    map(bufnr, "n", "gd", '<cmd>lua require"lspsaga.definition".preview_definition()<CR>', opts)

    map(bufnr, "n", "gh", '<cmd>lua require("lspsaga.hover").render_hover_doc(<CR>', opts)
    map(bufnr, "n", "ga", '<cmd>lua require("lspsaga.codeaction").code_action()<CR>', opts)
    map(bufnr, "v", "ga", 'c<md><C-U>lua require("lspsaga.codeaction").range_code_action()<CR>', opts)
    map(bufnr, "n", "ch", '<cmd>lua require("lspsaga.signaturehelp").signature_help()<CR>', opts)
    map(bufnr, "n", "cr", '<cmd>lua require("lspsaga.rename").rename()<cr>', opts)

    map(bufnr, "n", "ge", "<cmd>Lspsaga show_line_diagnostics<cr>", opts)
    map(bufnr, "n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<cr>", opts)
    map(bufnr, "n", "]d", "<cmd>Lspsaga diagnostic_jump_next<cr>", opts)

    map(bufnr, "n", "gF", "<cmd>Lspsaga lsp_finder<CR>", opts)
    -- scroll up hover doc
    map(bufnr, "n", "<C-b>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1, '<c-b>')<cr>", opts)
    -- scroll down hover doc or scroll in definition preview
    map(bufnr, "n", "<C-f>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1, '<c-f>')<cr>", opts)
  end
  require("lsp_signature").on_attach({}, bufnr)
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
