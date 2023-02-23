local vim = vim

local function pcall_ret(status, ...)
  if status then
    return ...
  end
end

local function nil_wrap(fn)
  return function(...)
    return pcall_ret(pcall(fn, ...))
  end
end

local make_meta_accessor = vim.make_meta_accessor
  or function(get, set, del)
    vim.validate({
      get = { get, "f" },
      set = { set, "f" },
      del = { del, "f", true },
    })
    local mt = {}
    if del then
      function mt:__newindex(k, v)
        if v == nil then
          return del(k)
        end
        return set(k, v)
      end
    else
      function mt:__newindex(k, v)
        return set(k, v)
      end
    end
    function mt:__index(k)
      return get(k)
    end
    return setmetatable({}, mt)
  end

local function new_buf_lines_accessor(bufnr)
  local function get(k)
    if bufnr == nil and type(k) == "number" then
      return new_buf_lines_accessor(k)
    end
    return vim.api.nvim_buf_get_lines(bufnr or 0, k)
  end
  local function set(k, v)
    if type(k) ~= "number" then
      error(string.format("key %s is not number, but %s", k, type(k)))
    end
    if type(v) ~= "table" then
      error(string.format("val %s is not table or not have 3 items", v))
    end
    return vim.api.nvim_buf_set_lines(bufnr or 0, k, unpack(v))
  end
  return make_meta_accessor(nil_wrap(get), set)
end

vim.bl = rawget(vim, "bl") or new_buf_lines_accessor(nil)

return vim
