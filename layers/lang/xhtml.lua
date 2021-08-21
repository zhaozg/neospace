if vim.fn.executable('tidy') then
  vim.g.neoformat_xml_tidy = {
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
  vim.g.neoformat_xhtml_tidy = {
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
  vim.g.neoformat_enabled_xhtml = {'tidy'}
  vim.g.neoformat_enabled_xml = {'tidy'}
end

if vim.fn.executable('html-beautify') then
  vim.g.neoformat_enabled_xhtml = {'htmlbeautify'}
end
if vim.fn.executable('css-beautify') then
  vim.g.neoformat_enabled_css = {'cssbeautify'}
end
if vim.fn.executable('js-beautify') then
  vim.g.neoformat_enabled_javascript = {'jsbeautify'}
end

vim.cmd[[
augroup fmtxhtml
  autocmd!
  autocmd filetype xml,xhtml setlocal ts=2 sw=2 et tw=79 fen fdm=indent
  autocmd BufWritePre * if &ft == 'css' | undojoin | Neoformat | endif
augroup END
]]


