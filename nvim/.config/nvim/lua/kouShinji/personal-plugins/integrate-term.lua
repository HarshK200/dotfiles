local state = {
	floating = {
		buf = -1,
		win = -1,
	},
}

function CreateTerminalWindow()
	local width = vim.o.columns
	local height = math.floor(vim.o.lines * 0.33)
	local row = vim.o.lines - height - 1 -- -1 for cmd line

    buf_id = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_open_win(vim.api.nvim_create_buf(false, true), true, {
		relative = "editor",
		width = width,
		height = height,
		row = row,
		col = 0,
		style = "minimal",
		border = { "", "─", "", "", "", "", "", "" },
	})


end

-- CreateTerminalWindow()
