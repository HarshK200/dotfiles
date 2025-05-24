return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio", -- dependeny for nvim-dap-ui

		-- Installs the debug adapters using mason
		"jay-babu/mason-nvim-dap.nvim",
		"mason-org/mason.nvim",

		-- Add your own debuggers here
		-- TODO:(maybe add nvim dap-go here)
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		-- keymaps
		vim.keymap.set("n", "<C-F9>", function()
			-- INFO: creating window for output
			local filetype = vim.bo.filetype
			local width = vim.o.columns
			local height = math.floor(vim.o.lines * 0.33)
			local row = vim.o.lines - height
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

			if filetype == "cpp" then
				vim.fn.jobstart("make", {
					term = true, -- INFO: start a sudo terminal
					on_exit = function(_, exit_code)
						if not (exit_code > 0) then
							-- INFO: close build output window and starting the debugger after build is done
							vim.api.nvim_win_close(win_id, true)
							dap.continue()
						end
					end,
				})
			elseif filetype == "odin" then
				vim.fn.jobstart({ "odin", "build", ".", "-debug", "-out:bin/debug/out" }, {
					term = true, -- INFO: start a sudo terminal
					on_exit = function(_, exit_code)
						if not (exit_code > 0) then
							-- INFO: close build output window and starting the debugger after build is done
							vim.api.nvim_win_close(win_id, true)
							dap.continue()
						end
					end,
				})
			else
				print("No config found for filetype: " .. filetype)
			end
		end, { desc = "build the project for currently open filetype & starts the debugger with the built executable" })

		-- vim.keymap.set("n", "<C-F9>", ":lua require'dap'.continue()<CR>")
		vim.keymap.set("n", "<C-F10>", dap.step_over)
		vim.keymap.set("n", "<C-F11>", dap.step_into)
		vim.keymap.set("n", "<C-F12>", dap.step_out)
		vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint)

		-- actual dap setup
		require("mason-nvim-dap").setup({
			-- leaving the handlers empty automatically initializez them
			handlers = {},
			ensure_installed = {
				-- NOTE: install these debuggers via mason if needed but i'm just using gdb on my system
				-- and i'll probably use go binary for golang
			},
		})

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

		-- INFO: config for debug adapters

		dap.adapters.gdb = {
			type = "executable",
			command = "/usr/bin/gdb",
			args = { "-i", "dap" },
		}

		-- dap.
	end,
}
