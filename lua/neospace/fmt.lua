local M = {}

M.prettier = {
  extra_args = function(params)
    _ = params
    return { "--stdin-filepath", vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)), "--single-quote" }
  end
}

M.shfmt = {
  extra_args = function(params)
    _ = params
    return { "-i", 2 }
  end
}

M.uncrustify = {
  extra_args = function(params)
    local Path = require("plenary.path")
    local uncrustify_cfg = Path:new(params.root .. "/" .. ".uncrustify.cfg")
    local args = {}

    if uncrustify_cfg:exists() and uncrustify_cfg:is_file() then
      args = {
        "-c", uncrustify_cfg:absolute()
      }
    end
    return args
  end
}

return M
