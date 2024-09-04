-- vim-options
require("kouShinji.set")

-- Personoalized key-remaps
require("kouShinji.remaps")

-- Lazy package manager
require("kouShinji.init_lazy")

-- Personal autocommands
require("kouShinji.autocommands")

-- This fixes the clang utf-8 offset_encodings error
local notify = vim.notify
vim.notify = function(msg, ...)
	if msg:match("warning: multiple different client offset_encodings") then
		return
	end

	notify(msg, ...)
end
