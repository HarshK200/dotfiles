-- ansi_highlight.lua
local M = {}

local ns = vim.api.nvim_create_namespace("ansi_highlight")

-- Map ANSI codes to highlight groups
local ansi_colors = {
	["30"] = "AnsiBlack",
	["31"] = "AnsiRed",
	["32"] = "AnsiGreen",
	["33"] = "AnsiYellow",
	["34"] = "AnsiBlue",
	["35"] = "AnsiMagenta",
	["36"] = "AnsiCyan",
	["37"] = "AnsiWhite",
}

-- Setup highlight groups
local function define_highlight_groups()
	vim.cmd("highlight default AnsiRed     guifg=#ff0000 ctermfg=1")
	vim.cmd("highlight default AnsiGreen   guifg=#00ff00 ctermfg=2")
	vim.cmd("highlight default AnsiYellow  guifg=#ffff00 ctermfg=3")
	vim.cmd("highlight default AnsiBlue    guifg=#0000ff ctermfg=4")
	vim.cmd("highlight default AnsiMagenta guifg=#ff00ff ctermfg=5")
	vim.cmd("highlight default AnsiCyan    guifg=#00ffff ctermfg=6")
	vim.cmd("highlight default AnsiWhite   guifg=#ffffff ctermfg=7")
	vim.cmd("highlight default AnsiBlack   guifg=#000000 ctermfg=0")
end

-- Apply highlights using extmarks, respecting reset code
local function apply_ansi_highlights(bufnr)
	bufnr = bufnr or vim.api.nvim_get_current_buf()
	vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)

	for lnum = 0, vim.api.nvim_buf_line_count(bufnr) - 1 do
		local line = vim.api.nvim_buf_get_lines(bufnr, lnum, lnum + 1, false)[1]
		if not line:find("\27%[") then
			goto continue
		end

		local i = 1
		local col = 0
		local active_hl = nil
		local segments = {}

		while i <= #line do
			local esc_start, esc_end, code = line:find("\27%[([0-9]+)m", i)
			if esc_start then
				if active_hl and col < esc_start - 1 then
					table.insert(segments, { col, esc_start - 1, active_hl })
				end

				local next_col = esc_end + 1
				if code == "0" then
					active_hl = nil
				elseif ansi_colors[code] then
					active_hl = ansi_colors[code]
				end

				i = next_col
				col = next_col - 1 -- adjust for next slice start
			else
				break
			end
		end

		if active_hl and col < #line then
			table.insert(segments, { col, #line, active_hl })
		end

		-- Clean version of the line (stripped)
		local clean = line:gsub("\27%[[0-9]+m", "")
		vim.api.nvim_buf_set_lines(bufnr, lnum, lnum + 1, false, { clean })

		-- Apply highlights using extmarks
		for _, seg in ipairs(segments) do
			local start_col, end_col, hl = seg[1], seg[2], seg[3]
			vim.api.nvim_buf_set_extmark(bufnr, ns, lnum, start_col, {
				end_col = end_col,
				hl_group = hl,
				priority = 1000,
			})
		end

		::continue::
	end
end

-- Public function
function M.enable()
	define_highlight_groups()
	apply_ansi_highlights()
end

return M
