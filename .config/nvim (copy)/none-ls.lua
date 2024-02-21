return {
    "nvimtools/none-ls.nvim",
    config = function()
        local null_ls = require("null-ls")
        null_ls.setup({
            sources = {
                null_ls.builtins.formatting.stylua,
                null_ls.builtins.formatting.clang_format,
                null_ls.builtins.formatting.black,
                null_ls.builtins.formatting.goimports_reviser,
                null_ls.builtins.formatting.prettier,
            },
        })

        -- Setting the keymap to autoformat
        vim.keymap.set("n", "<leader>ff", vim.lsp.buf.format, {})
    end,
}
