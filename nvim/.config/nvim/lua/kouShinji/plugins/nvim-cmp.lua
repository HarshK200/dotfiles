return {
	-- Installing nvim-cmp
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		"hrsh7th/cmp-buffer", -- source for text in buffer
		"hrsh7th/cmp-path", -- source for file system paths
		"L3MON4D3/LuaSnip", -- snippet engine
		"saadparwaiz1/cmp_luasnip", -- autocompletion for luasnip
		"rafamadriz/friendly-snippets", -- vscode like snippets
	},

	config = function()
		local cmp = require("cmp")

		local luasnip = require("luasnip")
		-- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
		require("luasnip.loaders.from_vscode").lazy_load()
		-- adds my custom snippets
		require("luasnip.loaders.from_vscode").load({ paths = "./snippets" })

		cmp.setup({
			completion = {
				completeopt = "menu,menuone,preview,noselect",
			},
			snippet = { -- configure
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},
			mapping = cmp.mapping.preset.insert({

				-- Keymaps for autocomplete
				["<C-p>"] = cmp.mapping.select_prev_item(), -- previous suggestion
				["<C-n>"] = cmp.mapping.select_next_item(), -- next suggestion
				["<C-k>"] = cmp.mapping.scroll_docs(-4), -- scroll docs down
				["<C-j>"] = cmp.mapping.scroll_docs(4), -- scroll docs up
				["<C-y>"] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item.
				["<C-e>"] = cmp.mapping.abort(), -- close completion suggestion
				["<C-a>"] = cmp.mapping.complete(), -- Show completion suggestion
			}),
			-- sources for autocompletion
			sources = cmp.config.sources({
				{ name = "luasnip" }, -- For luasnip users.
				{ name = "nvim_lsp" }, -- for built-in nvim_lsp autocompletion
				{ name = "buffer" }, -- for text autocompletion in the current buffer
				{ name = "path" }, -- for file path autocompletion
			}),
		})
	end,
}
