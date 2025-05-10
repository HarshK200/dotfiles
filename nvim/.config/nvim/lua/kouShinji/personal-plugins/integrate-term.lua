-- remaps double tap escape to exit terminal mode
vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>")
-- remaps ctrl+t to exit terminal mode and also
vim.keymap.set("t", "<C-t>", "<c-\\><c-n>:ToggleIntTerm<CR>")
-- remaps to if not a terminal then ToggleIntTerm and start insert mode
-- else if it is a terminal just ToggleIntTerm
local function toggle_int_term()
	if vim.bo.buftype == "terminal" then
		vim.cmd("ToggleIntTerm")
	else
		vim.cmd("ToggleIntTerm")
		vim.cmd("startinsert")
	end
end
vim.keymap.set("n", "<C-t>", toggle_int_term)

local state = {
	floating = {
		buf = -1,
		win = -1,
	},
}

function CreateTerminalWindow(opts)
	local width = vim.o.columns
	local height = math.floor(vim.o.lines * 0.33)
	local row = vim.o.lines - height - 1 -- -1 for cmd line

	local buf_id = nil
	if not (vim.api.nvim_buf_is_valid(opts.buf)) then
		buf_id = vim.api.nvim_create_buf(false, false)
	else
		buf_id = opts.buf
	end
	local win_id = vim.api.nvim_open_win(buf_id, true, {
		relative = "editor",
		width = width,
		height = height,
		row = row,
		col = 0,
		style = "minimal",
		border = { "", "─", "", "", "", "", "", "" },
	})
	return { buf = buf_id, win = win_id }
end

vim.api.nvim_create_user_command("ToggleIntTerm", function()
	if not vim.api.nvim_win_is_valid(state.floating.win) then
		state.floating = CreateTerminalWindow({ buf = state.floating.buf })
		if vim.bo[state.floating.buf].buftype ~= "terminal" then
			vim.cmd.terminal()
		end
	else
		vim.api.nvim_win_hide(state.floating.win)
	end
end, {})
