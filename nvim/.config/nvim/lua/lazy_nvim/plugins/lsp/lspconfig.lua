return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"mason-org/mason-lspconfig.nvim",
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{ "folke/neodev.nvim", opts = {} },
		"simrat39/rust-tools.nvim",
	},
	config = function()
		-- import cmp-nvim-lsp plugin
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		local keymap = vim.keymap -- for conciseness
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				-- Buffer local mappings.
				-- See `:help vim.lsp.*` for documentation on any of the below functions
				local opts = { buffer = ev.buf, silent = true }

				------------------------ LSP KEYBINDS ------------------------
				-- go to declaration
				keymap.set("n", "gD", vim.lsp.buf.declaration)

				-- go to definition
				keymap.set("n", "gd", vim.lsp.buf.definition)

				-- show available code actions
				keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action)

				-- smart rename
				keymap.set("n", "<leader>rn", vim.lsp.buf.rename)

				-- show full file i.e. buffer diagnostics
				keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>")

				-- show diagnostics for current line
				keymap.set("n", "<leader>d", vim.diagnostic.open_float)

				-- go to previous diagnostics
				keymap.set("n", "[d", function()
					vim.diagnostic.jump({ count = -1, float = true })
				end)

				-- go to previous next
				keymap.set("n", "]d", function()
					vim.diagnostic.jump({ count = 1, float = true })
				end, opts)

				-- show documentation for what is under cursor
				keymap.set("n", "K", function()
					vim.lsp.buf.hover({ border = "rounded" })
				end, opts)

				-- mapping to restart lsp if necessary
				opts.desc = "Restart LSP"
				keymap.set("n", "<leader>rs", ":LspRestart<CR>")
			end,
		})

		-- used to enable autocompletion (assign to every lsp server config)
		local capabilities = cmp_nvim_lsp.default_capabilities()

		-- Change the Diagnostic symbols in the sign column (gutter)
		-- (not in youtube nvim video)
		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		vim.lsp.config("lua_ls", {
			capabilities = capabilities,
			settings = {
				Lua = {
					runtime = {
						version = "LuaJIT",
					},
					diagnostics = {
						globals = { "vim" },
					},
					workspace = {
						library = {
							vim.env.VIMRUNTIME,
						},
					},
					telemetry = {
						enable = false, -- Disable telemetry
					},
				},
			},
		})
	end,
}
