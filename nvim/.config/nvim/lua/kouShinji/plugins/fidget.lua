return {
    -- The little lsp server loading progress thigi that appears on the bottom right of the screen
    "j-hui/fidget.nvim",
    config = function()
        require("fidget").setup({})
    end,
}
