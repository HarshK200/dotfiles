return {
	"folke/zen-mode.nvim",
	opts = {},
	config = function()
        require("zen-mode").setup({
            window = {
                width = 110,
            }
        })

        -- Keymaps
        vim.keymap.set("n", "<leader>zz", ":ZenMode<CR>")
    end,
}
