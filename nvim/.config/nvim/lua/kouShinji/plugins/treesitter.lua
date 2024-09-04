return {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = { "lua", "cpp", "python", "javascript", "typescript", "go", "dockerfile"},
            sync_install = false,
            auto_install = true, -- so that it automatically installs the treesitter parser for a file i haven't setup myself
            highlight = {
                enable = true,
            },
            indent = { enable = true },
        })
    end,
}
