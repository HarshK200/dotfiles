-- Setting <space> as the leader
vim.g.mapleader = " "

-- <space>pv executes :Ex
-- vim.keymap.set("n", "<leader>pv", ":Ex<CR>")

-- moves the cursor down and center's the screen there
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- keymaps to shift highlighted line up/down (shift + k) (shift + j)
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- key remaps to navigate to prev and next buffers
vim.api.nvim_set_keymap("n", "td", ":bdelete<CR>", { noremap = false })
vim.api.nvim_set_keymap("n", "<leader>bb", ":buffers<CR>", { noremap = false })

-- keymap to delete the selected word into the void register and paste from the yank register
vim.keymap.set("x", "<leader>p", '"_dP')

-- Keymap to copy to system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])

-- remaps ctrl+k and ctrl+j to cnext and cprev respectively
vim.keymap.set("n", "<C-k>", ":cprev<CR>")
vim.keymap.set("n", "<C-j>", ":cnext<CR>")

-- remaping the stupid fu*king sql filetype plugin omin_key from ctrl+c to ctrl+j
vim.g.ftplugin_sql_omni_key = "<C-j>"
