------------------------ REMAPS ------------------------
-- remaps double tap escape to exit terminal mode
vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>")

-- toggle terminal commands
vim.keymap.set({ "n" }, "<C-t>", ":IntTerm<CR>")
vim.keymap.set({ "t" }, "<C-t>", "<c-\\><c-n>:IntTerm<CR>")

---------------------- MAIN CODE ----------------------

local state = {
	floating = {
		buf = -1,
		win = -1,
	},
	-- delay in miliseconds to execute an command on the first terminal load
	-- because terminal takes time to open first time
	firstLoadDelay = 1000,
}

local IntTermGroup = vim.api.nvim_create_augroup("IntTermGroup", { clear = true })

-- This just creates the window for the terminal
-- NOTE: this does not open the terminal (it only opens a window)
local function CreateWindow(opts)
	local width = vim.o.columns
	local height = math.floor(vim.o.lines * 0.33)
	local row = vim.o.lines - height

	-- if buffer is not valid then create it else use the already valid buffer
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

---------------------- USER COMMANDS ----------------------

vim.api.nvim_create_user_command("IntTerm", function(opts)
	if not vim.api.nvim_win_is_valid(state.floating.win) then
		-- creating an floating window with a scratch buffer for the terminal to open in
		state.floating = CreateWindow({ buf = state.floating.buf })

		-- open the terminal if the buffer is doesn't have one (only possible when buffer is freshly opened)
		if vim.bo[state.floating.buf].buftype ~= "terminal" then
			vim.cmd.terminal()
		end
		vim.cmd("startinsert") -- puts you into insert i.e. terminal mode
	else
		vim.api.nvim_win_hide(state.floating.win)
	end
end, {})
