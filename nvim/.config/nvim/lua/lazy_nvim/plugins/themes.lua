return {
    "gmr458/cold.nvim",
    lazy = false,
    priority = 1000,
    init = function()
        vim.cmd.colorscheme("cold")

        -- slugbyte/lackluster.nvim
        --vim.cmd.colorscheme("lackluster-mint") -- NOTE: use this theme for lualine

    end,
}
