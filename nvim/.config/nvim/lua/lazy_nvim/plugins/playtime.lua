return {
	"harshk200/playtime.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		require("playtime").setup()
	end,
}
