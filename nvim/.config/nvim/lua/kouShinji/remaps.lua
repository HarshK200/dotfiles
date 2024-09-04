-- Setting <space> as the leader
vim.g.mapleader = " "

-- <space>pv executes :Ex
vim.keymap.set("n", "<leader>pv", ":Ex<CR>")

-- These are the primagen remaps to move vertically
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<n>", "nzzzv")
vim.keymap.set("n", "<N>", "Nzzzv")

-- key remap for shift+k and shift+j to move the selected line up and down visually
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- key remaps to navigate to prev and next buffers
vim.api.nvim_set_keymap("n", "]b", ":bnext<CR>", { noremap = false })
vim.api.nvim_set_keymap("n", "[b", ":bprev<CR>", { noremap = false })
vim.api.nvim_set_keymap("n", "td", ":bdelete<CR>", { noremap = false })
vim.api.nvim_set_keymap("n", "<leader>bb", ":buffers<CR>", { noremap = false })

-- keymap to delete the selected word into the void register and paste from the delte register
vim.keymap.set("x", "<leader>p", '"_dP')

-- Keymap to copy to system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])

-- remaps ctrl+t to tmux-sessionizer
vim.keymap.set("n", "<C-t>", "<cmd>tmux-sessionizer.sh<CR>")

-- remaps ctrl+k and ctrl+j to cnext and cprev respectively
vim.keymap.set("n", "<C-k>", ":cprev<CR>")
vim.keymap.set("n", "<C-j>", ":cnext<CR>")
