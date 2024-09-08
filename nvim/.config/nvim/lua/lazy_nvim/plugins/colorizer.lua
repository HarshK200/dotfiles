return {
    "norcalli/nvim-colorizer.lua",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        require("colorizer").setup {
            "css",
            "javascript",
            "html",
        }
    end
}
