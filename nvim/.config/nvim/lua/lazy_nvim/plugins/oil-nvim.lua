return {
	"stevearc/oil.nvim",
	dependencies = {
		"echasnovski/mini.icons",
	},
	config = function()
		require("oil").setup({
			view_options = {
				show_hidden = true,
			},
			default_file_explorer = true,
		})

		vim.keymap.set("n", "<space>pv", "<CMD>Oil<CR>", { desc = "Open parent directory" })
	end,
}
