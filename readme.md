# Neospace

Neospace is a fork of [space-vim](https://github.com/liuchengxu/space-vim), but update widley.

To be honest, [space-vim](https://github.com/liuchengxu/space-vim) is a good vim integrated tools, but I want to satisfy my personal preferences.

The name `neospace` come from [neovim](https://github.com/neovim/neovim) and [space-vim](https://github.com/liuchengxu/space-vim). That means neospace only aims to neovim, not vim.

Neospace will be in alpha stage in a long time, and bugs maybe will never be handle, so anyone use it with caution.

## Install

```sh
mkdir -p ~/Private && cd ~/Private && git clone https://github.com/zhaozg/neospace
mkdir ~/.config/nvim ~/.config/neospace
ln -s ~/Private/neospace/init.vim ~/.config/nvim/init.vim
vim ~/.config/neospace/init.vim   # custom stage before any layer or plugin load
vim ~/.config/neospace/config.vim # custom state after all layer or plugins load
```

## TODO

- fix:

  * ☐ update leader and localleader
  * ☐ fix keymaps

- document:

  * ☐ add doc
  * ☐ more details

- enhance:

  * ☐ use more lua replace vim

## Credits

- nvim.lua come from https://github.com/norcalli/nvim.lua.

## Knowledge Base

- [spf13-vim](https://github.com/spf13/spf13-vim)
- [space-vim](https://github.com/liuchengxu/space-vim)
- [mhinz](https://github.com/mhinz/dotfiles/tree/master/.vim)
- [junegunn](https://github.com/junegunn/dotfiles/blob/master/vimrc)

