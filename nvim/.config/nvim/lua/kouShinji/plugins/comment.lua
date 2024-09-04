return {
	"numToStr/Comment.nvim",
	opts = {
		-- add any options here
	},
	lazy = false,
	config = function()
		-- Use default configuration
		require("Comment").setup({
			--Add a space b/w comment and the line
			padding = true,
			-- Whether the cursor should stay at its position
			sticky = false,

			--LHS of toggle mappings in NORMAL mode
			toggler = {
				--Line-comment toggle keymap
				line = "<leader>cl",
				--Block-comment toggle keymap
				block = "<leader>cm",
			},
			---LHS of operator-pending mappings in NORMAL and VISUAL mode
			opleader = {
				-- Line-comment keymap
				line = "<leader>cl",
				-- Block-comment keymap
				block = "cm",
			},

			--Enable keybindings
			--NOTE: If given `false` then the plugin won't create any mappings
			mappings = {
				---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
				basic = true,
				---Extra mapping; `gco`, `gcO`, `gcA`
				extra = false,
			},
		})
	end,
}
