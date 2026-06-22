return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main", -- Ensure we are on the new branch
	lazy = false, -- Main branch does not support lazy loading
	build = ":TSUpdate",
	config = function()
		-- FORCE tree-sitter to use GCC instead of cl.exe
		vim.env.CC = "gcc"

		local ts = require("nvim-treesitter")

		-- 1. Create a safe, permanent folder for your parsers outside of Temp
		local install_dir = vim.fn.stdpath("data") .. "/site"
		vim.fn.mkdir(install_dir, "p")
		vim.opt.runtimepath:append(install_dir)

		-- 2. Initialize treesitter with your custom directory
		ts.setup({
			install_dir = install_dir,
		})

		-- 3. Pass your languages to install
		local my_language = {
			"lua",
			"cpp",
			"python",
			"javascript",
			"typescript",
			"go",
			"dockerfile",
		}
		ts.install(my_language)

		-- 4. Automatically attach highlighting and indentation
		vim.api.nvim_create_autocmd("FileType", {
			pattern = my_language,
			callback = function(args)
				local ft = vim.bo[args.buf].filetype
				local lang = vim.treesitter.language.get_lang(ft) or ft

				-- Enable highlighting natively
				local ok = pcall(vim.treesitter.start, args.buf)

				-- Fallback to install the parser if it's completely missing
				if not ok and ts.install then
					pcall(ts.install, { lang })
				end

				-- Enable native treesitter indentation
				vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end,
		})
	end,
}
