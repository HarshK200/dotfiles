local catppuccin = "catppuccin/nvim"
local rosepine = "rose-pine/neovim"
local tokyonight = "folke/tokyonight.nvim"
local solarized_osaka = "craftzdog/solarized-osaka.nvim"
local gruvbox = "ellisonleao/gruvbox.nvim"
local vscode = "Mofiqul/vscode.nvim"

return {
	vscode,
	config = function()
		-- Below two lines makes the window transparent
		vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
		vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })


		--(Uncomment below to use any of the themes && REMEMBER TO COMMENT THE CURRENT THEME)
		--solarized_osaka theme
		--vim.cmd[[colorscheme solarized_osaka]]
		-- vim.cmd([[colorscheme gruvbox]])


		vim.o.background = "dark" -- or "light" for light mode
        local c = require('vscode.colors').get_colors()
        vim.cmd.colorscheme "vscode"
	end,
	opts = ...,
}
