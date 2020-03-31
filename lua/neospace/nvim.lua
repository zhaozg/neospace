local nvim = require'nvim'
local vim = nvim.vim

local unpack = unpack or table.unpack

local function new_buf_lines_accessor(bufnr)
  local function get(k)
    if bufnr == nil and type(k) == 'number' then
      return new_buf_lines_accessor(k)
    end
    return nvim.api.nvim_buf_get_lines(bufnr or 0, k)
  end
  local function set(k, v)
    if type(k)~='number' then
        error(string.format('key %s is not number, but %s', k, type(k)))
    end
    if type(v)~='table' then
        error(string.format('val %s is not table or not have 3 items', v))
    end
    return vim.api.nvim_buf_set_lines(bufnr or 0, k, unpack(v))
  end
  return nvim.make_meta_accessor(nvim.nil_wrap(get), set)
end


nvim.bl = rawget(vim, "bl") or new_buf_lines_accessor(nil);

return nvim
