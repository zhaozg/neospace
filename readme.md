# Neospace

当我开始使用 MacBookPro 作为开发工具时，Neovim 发布了 v0.2 版本。

出于对 Lua 与控制台 (Console) 的偏爱，我强迫自己尽量使用 Neovim 完成日常工作。

vim 有诸多的优秀插件，Neovim 的发展也导致了大量后起之秀的产生。

如何管理和使用这些插件就成了需要解决的问题。

受到 [space-vim](https://github.com/liuchengxu/space-vim) 及其作者的影响，学着自己作一个插件管理工具，用来满足日常的工作所需。

Neospace is a simple Neovim plugins and layers management toolkit.

**!!!** Neospace 基于 Lua，因此不支持 vim。

## Principles

1. 非必要，不增加更多模块。在保持适当的插件规模的情况下，解决碰到的问题。
2. 插件默认配置优先，非必要不对插件的配置，如 `keymap` 进行重新设置。
3. 流行的插件优先、知名作者的插件优先。

## Plugins and Layers

A plugin is a git repo to extend the functionality of vim/Neovim.

A layer is a set of function-related, similar purpose plugins of Neovim.

## Dev

### lint

```sh
luacheck `fd \\.lua`
```

### test

We use a busted wrapper for testing neovim plugin, [vusted](https://github.com/notomo/vusted).

```sh
vusted
```

## Honor roll

### Soul figures

- [folke](https://github.com/folke)
- [hrsh7th](https://github.com/hrsh7th)
- [lewis6991](https://github.com/lewis6991)
- [tpope](https://github.com/tpope)

### core plugins

- [hrsh7th/nvim-cmp](https://github.com/hrsh7th/nvim-cmp)
- [williamboman/mason.nvim](https://github.com/williamboman/mason.nvim)
- [nvimtools/none-ls.nvim](https://github.com/nvimtools/none-ls.nvim)
