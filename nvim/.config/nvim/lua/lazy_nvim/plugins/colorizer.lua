return {
	"norcalli/nvim-colorizer.lua",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		require("colorizer").setup({
			"css",
			"javascript",
			"typescript",
			"html",
			"javascriptreact",
			"typescriptreact",
		})
	end,
}
