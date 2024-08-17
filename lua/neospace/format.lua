local function get_filter(bufnr, tidy)
  local sources = require("null-ls.sources")

  return function(client)

    if not tidy and client.name then
      return true
    end

    local found = false

    local ft = vim.api.nvim_buf_get_option(bufnr, "filetype")
    local supported = sources.get_supported(ft)
    -- the metadata is indexed by the builtin-names
    for method, names in pairs(supported) do
      if method == 'formatting' then
        for i = 1, #names do
          found = names[i] == tidy
          if found then
            break
          end
        end
      end
    end

    return found or tidy == client.name
  end
end

local function format(bufnr, tidy)
  bufnr = bufnr or 0

  vim.lsp.buf.format({
    filter = get_filter(bufnr, tidy),
    bufnr = bufnr,
  })
end

vim.api.nvim_create_user_command('Format', function(opts)
  format(vim.fn.bufnr(), opts.fargs and opts.fargs[1] or nil)
end, {nargs = '*'})

return format
