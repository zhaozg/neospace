local M = {}

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
  exe = "uncrustify",
  args = { "-q", "-l JAVA" },
  stdin = true,
}

M.c = {
  exe = "uncrustify",
  args = { "-q", "-l C" },
  stdin = true,
}

M.cpp = {
  exe = "uncrustify",
  args = { "-q", "-l CPP" },
  stdin = true,
}

M.objc = {
  exe = "uncrustify",
  args = { "-q", "-l OC" },
  stdin = true,
}

M.objcpp = {
  exe = "uncrustify",
  args = { "-q", "-l OC+" },
  stdin = true,
}

M.xml = {
  exe = "tidy",
  args = {
    "-quiet",
    "-xml",
    "-utf8",
    "--indent auto",
    "--indent-spaces 2",
    "--vertical-space yes",
    "--tidy-mark no",
  },
  stdin = true,
}

M.xhtml = {
  exe = "tidy",
  args = {
    "-quiet",
    "-asxhtml",
    "-utf8",
    "--indent auto",
    "--indent-spaces 2",
    "--vertical-space yes",
    "--tidy-mark no",
  },
  stdin = true,
}

M.markdown = {
  exe = "prettier",
}

return M
