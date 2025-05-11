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
		-- keymaps
		vim.keymap.set("n", "<S-F9>", ":lua require'dap'.continue()<CR>")
		vim.keymap.set("n", "<S-F10>", ":lua require'dap'.step_over()<CR>")
		vim.keymap.set("n", "<S-F11>", ":lua require'dap'.step_into()<CR>")
		vim.keymap.set("n", "<S-F12>", ":lua require'dap'.step_out()<CR>")
		vim.keymap.set("n", "<leader>b", ":lua require'dap'.toggle_breakpoint()<CR>")

		local dap = require("dap")
		local dapui = require("dapui")

		-- actual dap setup
		require("mason-nvim-dap").setup({
			-- leaving the handlers empty automatically initializez them
			handlers = {},
			ensure_installed = {
				"delve", -- for golang
				"codelldb", -- for c++
			},
		})

		-- golang dap config
		require("dap-go").setup()

		------------------------ DAP UI SETUP ------------------------
		dapui.setup({
			icons = { expanded = "▾", collapsed = "▸", current_frame = "*" },
			controls = {
				icons = {
					pause = "⏸",
					play = "▶",
					step_into = "⏎",
					step_over = "⏭",
					step_out = "⏮",
					step_back = "b",
					run_last = "▶▶",
					terminate = "⏹",
					disconnect = "⏏",
				},
			},
		})
		-- Change breakpoint icons NOTE: make sure you have nerd font insalled
		vim.api.nvim_set_hl(0, "DapBreak", { fg = "#e51400" })
		vim.api.nvim_set_hl(0, "DapStop", { fg = "#ffcc00" })
		local breakpoint_icons = {
			Breakpoint = "●",
			BreakpointCondition = "⊜",
			BreakpointRejected = "⊘",
			LogPoint = "◆",
			Stopped = "⭔",
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
	end,
}
