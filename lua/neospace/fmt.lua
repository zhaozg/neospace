local M = {}

M.c = {
  exe = "astyle",
  args = {'--mode=c', '--style=bsd --indent=spaces=2'},
  stdin = true,
  cwd = vim.fn.expand("%:p:h"), -- Run clang-format in cwd of the file.
}

M.javascript = {
  exe = "prettier",
  args = { "--stdin-filepath", vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)), "--single-quote" },
  stdin = true,
}

M.sh = {
  exe = "shfmt",
  args = { "-i", 2 },
  stdin = true,
}

M.lua = {
  exe = "stylua",
  args = {
    "--config-path " .. (os.getenv("XDG_CONFIG_HOME") or "~/.config") .. "/stylua/stylua.toml",
    "-",
  },
  stdin = true,
}

M.java = {
  exe = "astyle",
  args = {'--mode=java', '--style=java --indent=spaces=4'},
  stdin = true,
  cwd = vim.fn.expand("%:p:h"), -- Run clang-format in cwd of the file.
}

M.objc = {
  exe = 'uncrustify',
  args = {'-q', '-l OC'},
  stdin = 1,
}

M.objcpp = {
  exe = 'uncrustify',
  args = {'-q', '-l OC+'},
  stdin = 1,
}

M.xml = {
  exe= 'tidy',
  args= {'-quiet',
         '-xml',
         '-utf8',
         '--indent auto',
         '--indent-spaces 2',
         '--vertical-space yes',
         '--tidy-mark no'
        },
  stdin= 1,
}

M.xhtml = {
  exe = 'tidy',
  args = {'-quiet',
          '-asxhtml',
          '-utf8',
          '--indent auto',
          '--indent-spaces 2',
          '--vertical-space yes',
          '--tidy-mark no'
         },
  stdin = 1,
}

M.markdown = {
  exe = "prettier"
}

return M

