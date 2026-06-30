return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main", -- Ensure we are on the new branch
	lazy = false, -- treesitter doesn't support lazy loading
	build = ":TSUpdate",
	config = function()
		-- FORCE tree-sitter to use GCC instead of cl.exe
		vim.env.CC = "gcc"

		require("nvim-treesitter").setup({
			-- Directory to install parsers and queries to (prepended to `runtimepath` to have priority)
			install_dir = vim.fn.stdpath("data") .. "/site",
		})

		-- install language parsers that i use
		local my_languages = {
			"lua",
			"cpp",
			"python",
			"javascript",
			"typescript",
			"go",
			"dockerfile",
			"java",
		}
		require("nvim-treesitter").install(my_languages)
	end,
}
