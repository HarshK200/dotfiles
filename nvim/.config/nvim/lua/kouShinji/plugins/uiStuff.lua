return {
	{
		-- The line that that comes with the indent
		"lukas-reineke/indent-blankline.nvim",
        event = { "BufReadPre", "BufNewFile" },
		opts = {
			indent = {
				char = "│",
				tab_char = "│",
			},
			scope = { enabled = false },
			exclude = {
				filetypes = {
					"help",
					"alpha",
					"dashboard",
					"lazy",
					"mason",
					"notify",
					"toggleterm",
					"lazyterm",
				},
			},
		},
		main = "ibl",
	},
	{
		-- Animates the indentline and also highlights the scope we are in currently
		"echasnovski/mini.indentscope",
        event = { "BufReadPre", "BufNewFile" },
		version = false,
		init = function()
			vim.api.nvim_create_autocmd("FileType", {
				pattern = {
					"help",
					"alpha",
					"dashboard",
					"lazy",
					"mason",
					"notify",
					"toggleterm",
					"lazyterm",
				},
				callback = function()
					vim.b.miniindentscope_disable = true
				end,
			})
		end,
		config = function()
			local mini_indent = require("mini.indentscope")
            mini_indent.setup({
				-- symbol = "▏",
				symbol = "│",
				options = { try_as_border = true },
                draw = {
                    delay = 10,

                    --Setting the animation to none
                    animation = mini_indent.gen_animation.none()
                }
			})
		end,
	},
}
