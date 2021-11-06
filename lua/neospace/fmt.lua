local M = {}

M.c = {
  exe= 'astyle',
  args= {'--mode=c', '--style=allman', '--indent=spaces=2'},
  stdin= 1
}

M.lua = {
  exe = 'lua-format',
  args = {'-c' .. os.getenv('HOME') .. '/.lua-format'}
}

M.java = {
  exe= 'astyle',
  args= {'--mode=java', '--indent=spaces=2'},
  stdin= 1
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

