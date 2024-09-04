return {
	"stevearc/conform.nvim",
	opts = {},
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "black" },
				cpp = { "clang_format" },
				go = { "goimports" },
				javascript = { "prettier" },
				typescript = { "prettier" },
				javascriptreact = { "prettier" },
				typescriptreact = { "prettier" },
				svelte = { "prettier" },
				css = { "prettier" },
				html = { "prettier" },
				json = { "fixjson" },
				yaml = { "prettier" },
				markdown = { "prettier" },
				graphql = { "prettier" },
				php = { "pretty-php" },
			},
			format_on_save = false,
		})

		vim.keymap.set({ "n", "v" }, "<leader>ff", function()
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 500,
			})
			vim.cmd([[ColorizerReloadAllBuffers]])
		end)
	end,
}
