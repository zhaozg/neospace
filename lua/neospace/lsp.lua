local nvim = require'nvim'
local vim = nvim.vim
local api = vim.api

local nvim_lsp = require('nvim_lsp')

local on_attach = function(client, bufnr)
  bufnr = bufnr or 0

  local resolved_capabilities = client.resolved_capabilities

  -- Mappings.
  local opts = {noremap = true, silent = true}
  api.nvim_buf_set_keymap(bufnr, "n", "gD",
                          "<Cmd>lua show_diagnostics_details()<CR>", opts)
  api.nvim_buf_set_keymap(bufnr, "n", "gd",
                          "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
  api.nvim_buf_set_keymap(bufnr, "n", "gi",
                          "<Cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  api.nvim_buf_set_keymap(bufnr, "n", "gK", "<Cmd>lua vim.lsp.buf.hover()<CR>",
                          opts)
  api.nvim_buf_set_keymap(bufnr, "n", "gh",
                          "<Cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  api.nvim_buf_set_keymap(bufnr, "n", "gr",
                          "<Cmd>lua vim.lsp.buf.references()<CR>", opts)
  api.nvim_buf_set_keymap(bufnr, "n", "gF",
                          "<Cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  api.nvim_buf_set_keymap(bufnr, "n", "ga",
                          "<Cmd>lua request_code_actions()<CR>", opts)
  api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gD',
                          '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gR',
                          '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  api.nvim_buf_set_keymap(bufnr, 'n', '<leader>e',
                          '<cmd>lua vim.lsp.util.show_line_diagnostics()<CR>',
                          opts)
  if resolved_capabilities.document_highlight then
    api.nvim_command [[autocmd CursorHold  <buffer> lua vim.lsp.buf.document_highlight()]]
    api.nvim_command [[autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()]]
  end
  api.nvim_command [[autocmd CursorMoved <buffer> lua vim.lsp.util.buf_clear_references()]]

  require'diagnostic'.on_attach(client, bufnr)
end

local M = {}

M.on_attach = on_attach

M.setup = function(name, opts)
  opts.on_attach = opts.on_attach or on_attach
  nvim_lsp[name].setup(opts)
end

return M
