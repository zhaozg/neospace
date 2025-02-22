local map = require("neospace").map

map("n", "<Leader>q", "<cmd>q<CR>")

-- buffer
map("n", "<Leader>b1", "<cmd>b1<CR>")
map("n", "<Leader>b2", "<cmd>b2<CR>")
map("n", "<Leader>b3", "<cmd>b3<CR>")
map("n", "<Leader>b4", "<cmd>b4<CR>")
map("n", "<Leader>b5", "<cmd>b5<CR>")
map("n", "<Leader>b6", "<cmd>b6<CR>")
map("n", "<Leader>b7", "<cmd>b7<CR>")
map("n", "<Leader>b8", "<cmd>b8<CR>")
map("n", "<Leader>b9", "<cmd>b9<CR>")
map("n", "<Leader>bd", "<cmd>bd<CR>")
map("n", "<Leader>bf", "<cmd>bfirst<CR>")
map("n", "<Leader>bl", "<cmd>blast<CR>")
map("n", "<Leader>bh", "<cmd>Alpha<CR>")
map("n", "<Leader>bp", "<cmd>bprevious<CR>")
map("n", "<Leader>bn", "<cmd>bnext<CR>")
map("n", "<Leader>bw", "<cmd>bw<CR>")

-- window
map("n", "<Leader>ww", "<C-W>w")
map("n", "<Leader>wr", "<C-W>r")
map("n", "<Leader>wc", "<C-W>c")
map("n", "<Leader>wq", "<C-W>q")
map("n", "<Leader>wj", "<C-W>j")
map("n", "<Leader>wk", "<C-W>k")
map("n", "<Leader>wh", "<C-W>h")
map("n", "<Leader>wl", "<C-W>l")
map("n", "<Leader>w>", "<C-W>5<")
map("n", "<Leader>w<", "<C-W>5>")
map("n", "<Leader>w+", "<cmd>resize +5<CR>")
map("n", "<Leader>w-", "<cmd>resize -5<CR>")
map("n", "<Leader>w=", "<C-W>=")
map("n", "<Leader>ws", "<C-W>s")
map("x", "<Leader>ws", "<C-W>s")
map("n", "<Leader>wv", "<C-W>v")
map("x", "<Leader>wv", "<C-W>v")

-- text
map("n", "<Leader>xc", "<cmd>nohlsearch<CR>")
map("n", "<Leader>xd", "<cmd>setlocal ff=dos<CR>")
map("n", "<Leader>xu", "<cmd>setlocal ff=unix<CR>")
map("n", "<Leader>xs", "<cmd>Trim<CR>")

-- fold
map("n", "<Leader>z0", "<cmd>set foldlevel=0<CR>")
map("n", "<Leader>z1", "<cmd>set foldlevel=1<CR>")
map("n", "<Leader>z2", "<cmd>set foldlevel=2<CR>")
map("n", "<Leader>z3", "<cmd>set foldlevel=3<CR>")
map("n", "<Leader>z4", "<cmd>set foldlevel=4<CR>")
map("n", "<Leader>z5", "<cmd>set foldlevel=5<CR>")
map("n", "<Leader>z6", "<cmd>set foldlevel=6<CR>")
map("n", "<Leader>z7", "<cmd>set foldlevel=7<CR>")
map("n", "<Leader>z8", "<cmd>set foldlevel=8<CR>")
map("n", "<Leader>z9", "<cmd>set foldlevel=9<CR>")

-- toggle
map("n", "<Leader>tr", "<cmd>setlocal colorcolumn=80<CR>", { desc = "Toggle colorcolumn" })
map("n", "<Leader>tt", "<cmd>Outline<CR>", { desc = "Toggle Outline" })
map("n", "<Leader>tf", "<cmd>Neotree<CR>", { desc = "Toggle Neotree" })
