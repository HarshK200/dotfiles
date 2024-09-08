return {
	"kevinhwang91/nvim-ufo",
	dependencies = {
		"kevinhwang91/promise-async",
		{
			"luukvbaal/statuscol.nvim",
			opts = function()
				local builtin = require("statuscol.builtin")
				return {
					setopt = true,
					-- override the default list of segments with:
					-- number-less fold indicator, then signs, then line number & separator
					segments = {
						{ text = { builtin.foldfunc }, click = "v:lua.ScFa" },
						{ text = { "%s" }, click = "v:lua.ScSa" },
						{
							text = { builtin.lnumfunc, " " },
							condition = { true, builtin.not_empty },
							click = "v:lua.ScLa",
						},
					},
				}
			end,
		},
	},
	config = function()
		vim.o.foldcolumn = "1" -- '0' is not bad
		vim.o.foldlevel = 1 -- Using ufo provider need a large value, feel free to decrease the value
		vim.o.foldlevelstart = 99
		vim.o.foldenable = true
		vim.cmd([[ set fillchars=foldopen:▾,foldclose:▸ ]])
		vim.cmd([[ highlight Folded guifg=None guibg=None ]])

		-- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
		vim.keymap.set("n", "zr", require("ufo").openAllFolds)
		vim.keymap.set("n", "zm", require("ufo").closeAllFolds)
		vim.keymap.set("n", "zk", function()
			local windid = require("ufo").peekFoldedLinesUnderCursor()
			if not windid then
				vim.lsp.buf.hover()
			end
		end)

		require("ufo").setup({
			provider_selector = function()
				return { "lsp" }
			end,
		})
	end,
}
