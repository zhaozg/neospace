local vim = vim

local map = require("neospace").map

-- real settings in your custom layers
local settings = {}

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
  map(bufnr, "n", "gf", "<cmd>lua vim.lsp.buf.format()<CR>")
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
    map(bufnr, "n", "gh", "<cmd>Lspsaga hover_doc<CR>")
    map(bufnr, "n", "ga", "<cmd>Lspsaga code_action<CR>")
    map(bufnr, "n", "cr", "<cmd>Lspsaga rename<CR>")

    map(bufnr, "n", "ge", "<cmd>Lspsaga show_line_diagnostics<cr>")
    map(bufnr, "n", "ge", "<cmd>Lspsaga show_cursor_diagnostics<cr>")
    map(bufnr, "n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<cr>")
    map(bufnr, "n", "]e", "<cmd>Lspsaga diagnostic_jump_next<cr>")

    map(bufnr, "n", "gF", "<cmd>Lspsaga lsp_finder<CR>")
  end

  for _, v in pairs(settings[client.name]._on_attach) do
    v(client, bufnr)
  end
end

local function make_config(defaults, options)
  assert(defaults)
  options = options or {}

  if not options.capabilities then
    defaults.capabilities = vim.lsp.protocol.make_client_capabilities()
    -- enable snippet support
    defaults.capabilities.textDocument.completion.completionItem.snippetSupport = true
  end

  if not defaults._on_attach then
    defaults._on_attach = {}
    defaults.on_attach = on_attach
  end

  if options.on_attach then
    defaults._on_attach[#defaults._on_attach + 1] = options.on_attach
    options.on_attach = nil
  end

  defaults = vim.tbl_extend("force", defaults, options)

  return defaults
end

return {
  settings = settings,
  setting = function(name, options)
    options = options or {}
    local defaults = settings[name] or {}
    settings[name] = make_config(defaults, options)
    return settings[name]
  end,
}
