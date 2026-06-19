-- enables highlight when yanking/copying
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlights the text when yanked",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- for plugins auto update
vim.api.nvim_create_autocmd("VimEnter", {
	group = vim.api.nvim_create_augroup("autoupdate", { clear = true }),
	callback = function()
		require("lazy").update({ show = false })
	end,
})

-- disable that annoying make new buffer in netrw keybind
vim.api.nvim_create_autocmd("FileType", {
	pattern = "netrw",
	callback = function(args)
		for _, map in ipairs(vim.api.nvim_buf_get_keymap(args.buf, "n")) do
			-- check if keymap is set before deleting
			if map.lhs == "t" then
				vim.keymap.del("n", "t", { buffer = args.buf })
				break
			end
		end
	end,
})

-- Set indenting to 2 spaces for specific filetypes
vim.api.nvim_exec2(
	[[
  autocmd FileType javascript,javascriptreact,typescript,typescriptreact,html,css,json setlocal shiftwidth=2
  autocmd FileType javascript,javascriptreact,typescript,typescriptreact,html,css,json setlocal softtabstop=2
  autocmd FileType javascript,javascriptreact,typescript,typescriptreact,html,css,json setlocal tabstop=2
  autocmd FileType javascript,javascriptreact,typescript,typescriptreact,html,css,json setlocal expandtab
]],
	{ output = false }
)

-- change cursor to a vertical line in insert mode
vim.api.nvim_exec2(
	[[
  autocmd InsertEnter * silent! execute 'let &t_SI = "\e[6 q"'
  autocmd InsertLeave * silent! execute 'let &t_EI = "\e[2 q"'
]],
	{
		output = false,
	}
)
