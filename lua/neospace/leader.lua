local keymap = vim.api.nvim_set_keymap

-- buffer
keymap("n", "<Leader>b1", [[<cmd>b1<CR>]], { noremap = true })
keymap("n", "<Leader>b2", [[<cmd>b2<CR>]], { noremap = true })
keymap("n", "<Leader>b3", [[<cmd>b3<CR>]], { noremap = true })
keymap("n", "<Leader>b4", [[<cmd>b4<CR>]], { noremap = true })
keymap("n", "<Leader>b5", [[<cmd>b5<CR>]], { noremap = true })
keymap("n", "<Leader>b6", [[<cmd>b6<CR>]], { noremap = true })
keymap("n", "<Leader>b7", [[<cmd>b7<CR>]], { noremap = true })
keymap("n", "<Leader>b8", [[<cmd>b8<CR>]], { noremap = true })
keymap("n", "<Leader>b9", [[<cmd>b9<CR>]], { noremap = true })
keymap("n", "<Leader>bd", [[<cmd>bd<CR>]], { noremap = true })
keymap("n", "<Leader>bf", [[<cmd>bfirst<CR>]], { noremap = true })
keymap("n", "<Leader>bl", [[<cmd>blast<CR>]], { noremap = true })
keymap("n", "<Leader>bh", [[<cmd>Alpha<CR>]], { noremap = true })
keymap("n", "<Leader>bp", [[<cmd>bprevious<CR>]], { noremap = true })
keymap("n", "<Leader>bn", [[<cmd>bnext<CR>]], { noremap = true })
keymap("n", "<Leader>bw", [[<cmd>bw<CR>]], { noremap = true })

-- window
keymap("n", "<Leader>ww", [[<C-W>w]], {noremap = true})
keymap("n", "<Leader>wr", [[<C-W>r]], {noremap = true})
keymap("n", "<Leader>wc", [[<C-W>c]], {noremap = true})
keymap("n", "<Leader>wq", [[<C-W>q]], {noremap = true})
keymap("n", "<Leader>wj", [[<C-W>j]], {noremap = true})
keymap("n", "<Leader>wk", [[<C-W>k]], {noremap = true})
keymap("n", "<Leader>wh", [[<C-W>h]], {noremap = true})
keymap("n", "<Leader>wl", [[<C-W>l]], {noremap = true})
keymap("n", "<Leader>w>", [[<C-W>5<]], {noremap = true})
keymap("n", "<Leader>w<", [[<C-W>5>]], {noremap = true})
keymap("n", "<Leader>w+", [[<cmd>resize +5<CR>]], {noremap = true})
keymap("n", "<Leader>w-", [[<cmd>resize -5<CR>]], {noremap = true})
keymap("n", "<Leader>w=", [[<C-W>=]], {noremap = true})
keymap("n", "<Leader>ws", [[<C-W>s]], {noremap = true})
keymap("x", "<Leader>ws", [[<C-W>s]], {noremap = true})
keymap("n", "<Leader>wv", [[<C-W>v]], {noremap = true})
keymap("x", "<Leader>wv", [[<C-W>v]], {noremap = true})

    -- text
keymap("n", "<Leader>xc", [[<cmd>nohlsearch<CR>]], {noremap = true})
keymap("n", "<Leader>xd", [[<cmd>setlocal ff=dos<CR>]], {noremap = true})
keymap("n", "<Leader>xu", [[<cmd>setlocal ff=unix<CR>]], {noremap = true})
keymap("n", "<Leader>xs", [[<cmd>StripWhitespace<CR>]], {noremap = true})

-- fold
keymap("n", "<Leader>z0", [[<cmd>set foldlevel=0<CR>]], {noremap = true})
keymap("n", "<Leader>z1", [[<cmd>set foldlevel=1<CR>]], {noremap = true})
keymap("n", "<Leader>z2", [[<cmd>set foldlevel=2<CR>]], {noremap = true})
keymap("n", "<Leader>z3", [[<cmd>set foldlevel=3<CR>]], {noremap = true})
keymap("n", "<Leader>z4", [[<cmd>set foldlevel=4<CR>]], {noremap = true})
keymap("n", "<Leader>z5", [[<cmd>set foldlevel=5<CR>]], {noremap = true})
keymap("n", "<Leader>z6", [[<cmd>set foldlevel=6<CR>]], {noremap = true})
keymap("n", "<Leader>z7", [[<cmd>set foldlevel=7<CR>]], {noremap = true})
keymap("n", "<Leader>z8", [[<cmd>set foldlevel=8<CR>]], {noremap = true})
keymap("n", "<Leader>z9", [[<cmd>set foldlevel=9<CR>]], {noremap = true})

keymap("n", "<Leader>tr", [[<cmd>setlocal colorcolumn=80<CR>]], {noremap = true})

