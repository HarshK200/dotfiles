return {
	"stevearc/oil.nvim",
	---@module 'oil'
	---@type oil.SetupOpts
	opts = {},
	-- Optional dependencies
	dependencies = { { "echasnovski/mini.icons", opts = {} } },
	-- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
	config = function()
		require("oil").setup({
			-- just shows all the hidden files
			view_options = {
				show_hidden = true,
			},
			default_file_explorer = true,
			use_default_keymaps = false,
			keymaps = {
				["<CR>"] = "actions.select",
			},
		})
		vim.keymap.set("n", "<space>pv", "<CMD>Oil<CR>", { desc = "Open parent directory" })
	end,
}
