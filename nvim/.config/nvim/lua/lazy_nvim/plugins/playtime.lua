return {
	"harshk200/playtime.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		require("playtime").setup({
			window = {
				relative = "editor",
				width = 8,
				height = 1,
				row = 0, -- row does defnies where to place on the y axis
				col = vim.o.columns, -- column does defines where to place on the x axis
				style = "minimal",
				focusable = false,
				noautocmd = true,
				border = "rounded",
				anchor = "NW",
				zindex = 150,
			},
			win_visible_on_startup = true, -- the window is visible on startup by default
		})

		vim.keymap.set("n", "<leader>pt", ":PlaytimeToggle<CR>")
	end,
}
