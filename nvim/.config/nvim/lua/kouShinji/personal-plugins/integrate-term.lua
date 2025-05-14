------------------------ REMAPS ------------------------
-- remaps double tap escape to exit terminal mode
vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>")

-- remaps ctrl+t to toggle terminal
local function toggle_int_term()
	local is_term_open = vim.api.nvim_exec2("IntTermIsOpen", { output = true })

	if is_term_open.output == "true" then
		vim.cmd("IntTermToggle")
	else
		vim.cmd("IntTermToggle")
		vim.cmd("startinsert")
	end
end
vim.keymap.set({ "n", "t" }, "<C-t>", toggle_int_term)

-- remaps <F10> to generate the bin files for c++ project
vim.keymap.set({ "n", "t" }, "<F10>", ':IntTermExecute "make"<CR>')

---------------------- MAIN CODE ----------------------

local state = {
	floating = {
		buf = -1,
		win = -1,
	},
}

local IntTermGroup = vim.api.nvim_create_augroup("IntTermGroup", { clear = true })

-- This just creates the window for the terminal
-- NOTE: this does not open the terminal (it only opens a window)
function CreateTerminalWindow(opts)
	local width = vim.o.columns
	local height = math.floor(vim.o.lines * 0.33)
	local row = vim.o.lines - height

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

vim.api.nvim_create_user_command("IntTermToggle", function()
	if not vim.api.nvim_win_is_valid(state.floating.win) then
		state.floating = CreateTerminalWindow({ buf = state.floating.buf })
		if vim.bo[state.floating.buf].buftype ~= "terminal" then
			vim.cmd.terminal()
		end
	else
		vim.api.nvim_win_hide(state.floating.win)
	end
end, {})

vim.api.nvim_create_user_command("IntTermIsOpen", function()
	print(vim.api.nvim_win_is_valid(state.floating.win))
end, {})

vim.api.nvim_create_user_command("IntTermExecute", function(args)
	-- if terminal not open then open it
	if not vim.api.nvim_win_is_valid(state.floating.win) then
		vim.cmd("IntTermToggle")
		vim.cmd("startinsert")
	end

	vim.defer_fn(function()
		local job_id = vim.bo.channel
		vim.fn.chansend(job_id, { args.args .. "\r\n" })
	end, 1000)
end, {})
