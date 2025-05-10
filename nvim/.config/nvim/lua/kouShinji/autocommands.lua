-- enables highlight when yanking/copying
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlights the text when yanked",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Set indenting to 2 spaces for specific filetypes
vim.api.nvim_exec(
	[[
  autocmd FileType javascript,javascriptreact,typescript,typescriptreact,html,css,json setlocal shiftwidth=2
  autocmd FileType javascript,javascriptreact,typescript,typescriptreact,html,css,json setlocal softtabstop=2
  autocmd FileType javascript,javascriptreact,typescript,typescriptreact,html,css,json setlocal tabstop=2
  autocmd FileType javascript,javascriptreact,typescript,typescriptreact,html,css,json setlocal expandtab
]],
	false
)

-- NOTE: for plugings auto update

vim.api.nvim_create_autocmd("VimEnter", {
	group = vim.api.nvim_create_augroup("autoupdate", { clear = true }),
	callback = function()
		require("lazy").update({ show = false })
	end,
})

--NOTE: for cursor change on insert
-- Change cursor to a vertical line in insert mode
vim.api.nvim_exec(
	[[
  autocmd InsertEnter * silent! execute 'let &t_SI = "\e[6 q"'
  autocmd InsertLeave * silent! execute 'let &t_EI = "\e[2 q"'
]],
	false
)


