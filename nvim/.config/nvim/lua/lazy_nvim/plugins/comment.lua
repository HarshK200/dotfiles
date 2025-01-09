return {
  "numToStr/Comment.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "JoosepAlviste/nvim-ts-context-commentstring",
  },
  config = function()
    -- import comment plugin safely
    local comment = require("Comment")

    -- local ts_context_commentstring = require("ts_context_commentstring.integrations.comment_nvim")

    -- enable comment
    comment.setup({
      -- for commenting tsx, jsx, svelte, html files
      -- pre_hook = ts_context_commentstring.create_pre_hook(),

      -- LHS of toggle mappings in NORMAL mode
      toggler = {
          --Line-comment toggle keymap
          line = "<leader>cl",
          --Block-comment toggle keymap
          block = "<leader>cm",
      },
      ---LHS of operator-pending mappings in NORMAL and VISUAL mode
      opleader = {
          -- Line-comment keymap
          line = "<leader>cl",
          -- Block-comment keymap
          block = "<leader>cm",
      },

      --Enable keybindings
      --NOTE: If given `false` then the plugin won't create any mappings
      mappings = {
          ---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
          basic = true,
          ---Extra mapping; `gco`, `gcO`, `gcA`
          extra = false,
      },
    })
  end,
}
