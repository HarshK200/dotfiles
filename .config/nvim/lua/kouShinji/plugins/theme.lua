local catppuccin = "catppuccin/nvim"
local rosepine = "rose-pine/neovim"
local tokyonight = "folke/tokyonight.nvim"
local solarized_osaka = "craftzdog/solarized-osaka.nvim"

return {
    catppuccin,
    name = "catppuccin",
    config = function()
        vim.cmd.colorscheme "catppuccin"
        --vim.cmd[[colorscheme solarized_osaka]]

        -- Below two lines makes the window transparent
        vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    end
}
