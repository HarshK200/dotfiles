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

vim.api.nvim_exec(
	[[
    autocmd FileType netrw nmap <buffer> D <Nop>
]],
	true
)

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlights the text when yanked",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- to remove the highlight thingi
vim.api.nvim_create_autocmd("BufWinEnter", {
  pattern = "*",
  callback = function()
    vim.cmd("highlight Folded guifg=None guibg=None")
  end,
})

