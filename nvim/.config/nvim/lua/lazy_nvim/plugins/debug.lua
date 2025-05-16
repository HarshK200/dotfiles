return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio", -- dependeny for nvim-dap-ui

		-- Installs the debug adapters using mason
		"jay-babu/mason-nvim-dap.nvim",
		"mason-org/mason.nvim",

		-- Add your own debuggers here
		"leoluz/nvim-dap-go",
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		-- keymaps
		vim.keymap.set("n", "<C-F9>", function()
			local width = vim.o.columns
			local height = math.floor(vim.o.lines * 0.33)
			local row = vim.o.lines - height
			local hadError = false

			local buf_id = vim.api.nvim_create_buf(false, true) -- create a new scratch buffer
			local win_id = vim.api.nvim_open_win(buf_id, true, {
				relative = "editor",
				width = width,
				height = height,
				row = row,
				col = 0,
				style = "minimal",
				border = { "", "─", "", "", "", "", "", "" },
			})

			-- TODO: add if else cases checking the current buffer type if its .cpp then
			-- call make else check for other like go for e.g.
			vim.fn.jobstart("make", {
				on_stdout = function(_, data)
					if data and not hadError then
						vim.api.nvim_buf_set_lines(buf_id, -2, -1, false, data)
					end
				end,
				on_stderr = function(_, err)
					if err[1] ~= "" then
						if not hadError then
							hadError = true
							vim.api.nvim_buf_set_lines(
								buf_id,
								-2,
								-1,
								false,
								{ "", "", "Error occured during compilation:", "", "" }
							)
						end
						vim.api.nvim_buf_set_lines(buf_id, -2, -1, false, err)
					end
				end,
				on_exit = function()
					if not hadError then
						vim.api.nvim_win_close(win_id, true)

						dap.continue()
					end
				end,
			})
		end, { desc = "this builds the project using make and then starts the debugger" })

		-- vim.keymap.set("n", "<C-F9>", ":lua require'dap'.continue()<CR>")
		vim.keymap.set("n", "<C-F10>", ":lua require'dap'.step_over()<CR>")
		vim.keymap.set("n", "<C-F11>", ":lua require'dap'.step_into()<CR>")
		vim.keymap.set("n", "<C-F12>", ":lua require'dap'.step_out()<CR>")
		vim.keymap.set("n", "<leader>b", ":lua require'dap'.toggle_breakpoint()<CR>")

		-- actual dap setup
		require("mason-nvim-dap").setup({
			-- leaving the handlers empty automatically initializez them
			handlers = {},
			ensure_installed = {
				-- NOTE: install these debuggers via mason if needed but i'm just using gdb on my system
				-- and i'll probably use go binary for golang

				-- "delve", -- for golang
				-- "codelldb", -- for c++
			},
		})

		-- golang dap config
		require("dap-go").setup()

		------------------------ DAP UI SETUP ------------------------
		dapui.setup({
			icons = { expanded = "", collapsed = "", current_frame = "" },
			controls = {
				icons = {
					pause = "",
					play = "",
					step_into = "󰿄",
					step_over = "",
					step_out = "",
					step_back = "",
					run_last = "▶▶",
					terminate = "",
					disconnect = "",
				},
			},
		})
		-- Change breakpoint icons NOTE: make sure you have nerd font insalled
		vim.api.nvim_set_hl(0, "DapBreak", { fg = "#e51400" })
		vim.api.nvim_set_hl(0, "DapStop", { fg = "#ffcc00" })
		local breakpoint_icons = {
			Breakpoint = "●",
			BreakpointCondition = "",
			BreakpointRejected = "⊘",
			LogPoint = "◆",
			Stopped = "",
		}
		for type, icon in pairs(breakpoint_icons) do
			local tp = "Dap" .. type
			local hl = (type == "Stopped") and "DapStop" or "DapBreak"
			vim.fn.sign_define(tp, { text = icon, texthl = hl, numhl = hl })
		end

		-- automatically opens/close the UI when the debugger starts
		dap.listeners.after.event_initialized["dapui_config"] = dapui.open
		dap.listeners.before.event_terminated["dapui_config"] = dapui.close
		dap.listeners.before.event_exited["dapui_config"] = dapui.close

		-- configuring debug adapters

		-- dap.configurations.cpp
		dap.adapters.gdb = {
			type = "executable",
			command = "/usr/bin/gdb",
			args = { "-i", "dap" },
		}
	end,
}
